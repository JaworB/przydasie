#!/bin/bash

###########################################################################################
#
#  upgrade8to9.sh
#
#  Script for performing in-place upgrades from RHEL 8.x to RHEL 9.X
#
#  Authors:
#            Paweł Kurzydłowski (KYNDRYL)
#            Bartosz Jawornicki (KYNDRYL)
#            Martyna Marzec (KYNDRYL)
#
#
#  Version: 1.0
#
#
##########################################################################################

# COLOR CONSTANTS

COLOROK="[0;32m"
COLORERR="[0;31m"
COLORWARN="[0;33m"
COLORINFO="[0;34m"
COLOROFF="[0;0m"
DISPLAY=1

# REQUIRED VARIABLES

hostname=$(hostname -s)
evidence_dir="/root/preupg-evidence"
log_file="${hostname}-upgrade.log"
state_file="${hostname}-upgrade.state"
verify_file="${hostname}-upgrade.verify"
log_path="/root"
satellite_env="dev"
server_type="normal"

#Leapp related variables
target_chan="e4s"
target_ver=9.2
leapp_data_ver=22


function usage(){
  echo "Usage: $0 <options>"
  echo "  Options:"
  echo "          rpmreport     - Generate non-Red Hat provided packages report"
  echo "          prepare       - Gather evidence, set icinga downtime"
  echo "          upgrade       - Perform VM upgrade"
  echo "          post          - Perform post upgrade tasks"
  echo "          verify_after  - Verify state after upgrade"
}


function rpmreport(){
  write_message "INFO" "Gathering info..."
  rpm -qa --qf "%-30{NAME} - %-10{VERSION} - %{VENDOR}\n" | egrep -v "Red Hat|gpg-pubkey|nagios|Puppet|BESClient|BESAgent|Icinga"
  write_message "INFO" "Please send list of non-Red Hat packages to requestor and server owners."
}


function write_mark(){
  echo "-----------------------------------------------------------"
}



function display_message(){
###########################################################################################
#
#   Function for logging and displaying messages
#   Usage:
#       write_message "<LEVEL>" "<Message>"
#   Where <LEVEL> is one of following:
#       OK
#       WARNING
#       ERROR
#       INFO
#   message is displayed on screen and logged into logfile set in the script variables
#
############################################################################################


  level=${1}
  timestamp=$(date +"%Y-%m-%dT%H:%M:%S")
  case ${level} in
    "OK")
      message="${COLOROK}${@:2}${COLOROFF}"
      ;;
    "WARNING")
      message="${COLORWARN}${@:2}${COLOROFF}"
      ;;
    "ERROR")
      message="${COLORERR}${@:2}${COLOROFF}"
      ;;
    "INFO")
      message="${COLORINFO}${@:2}${COLOROFF}"
        ;;
 *)
      message="${@:2}"
        ;;
  esac

  echo -e "${timestamp} ${level} ${message}" | tee -a ${log_path}/${log_file}
}


write_to_log(){
#########################################################################################
#
#   Function for writing directly to log
#
#   Usage:
#       write_message "<LEVEL>" "<Message>"
#   Where <LEVEL> is one of following:
#       OK
#       WARNING
#       ERROR
#       INFO
#
#########################################################################################
  timestamp=$(date +"%Y-%m-%dT%H:%M:%S")
  level=${1}
  msg=${@:2}
  echo "${timestamp} | ${level} | ${msg}" >> ${log_path}/${log_file}
}


function write_message(){
#################################################################################
#
#   function that decides if message should be written to screen or to log
#
#   Usage:
#       write_message "<LEVEL>" "<Message>"
#   Where <LEVEL> is one of following:
#       OK
#       WARNING
#       ERROR
#       INFO
#
#################################################################################

  if [[ ${DISPLAY} -eq 1 ]]; then
    display_message ${1} ${2}
    write_to_log ${1} ${@:2}
  fi
}

function install_requirements(){
#######################################################
#
#   Install required packages:
#   - leapp
#   - leapp-upgrade-el8toel9
#
########################################################

  # list of packages that are required for performing the upgrade
  packages_list="leapp leapp-upgrade-el8toel9.noarch vdo"

  # Verify if appstream repository is enabled.

  write_message "INFO" "Checking if Appstream repository is enabled"
  extras_enabled=$(dnf repolist --all | grep appstream | awk '{print $5}')
  if [[ ${extras_enabled} != "enabled" ]]; then
    write_message "WARNING" "AppStream repository not enabled... Enabling..."
    subscription-manager repos --enable=rhel-8-for-x86_64-appstream-rpms
    rc=$?
    if [[ ${rc} -ne 0 ]]; then
      write_message "ERROR" "Can't enable AppStream repository!"
      write_message "ERROR" "Please enable AppStream repository in secondary console before continuing!"
      read -p "Press [ENTER] to continue..."
    else
      write_message "OK" "AppStream repository enabled correctly"
    fi
  else
    write_message "OK" "AppStream repository already enabled."
 fi

  write_message "INFO" "Installing required packages"
  dnf install -y ${packages_list}
  rc=$?

  if [[ ${rc} -ne 0 ]]; then
    write_message "ERROR" "Can't install required packages!"
    write_message "ERROR" "${packages_list}"
    write_message "ERROR" "Please install packages in secondary console before continuing."
    read -p "Press [ENTER] to continue..."
  else
    write_message "OK" "Requirements installed correctly."
  fi
}


function gather_evidence(){
###############################################################################################
#
# Function for gathering evidence
#
###############################################################################################

  if [ -d ${evidence_dir} ]; then
      write_message "INFO" "Old evidence directory found, renaming to _prev"
      mv ${evidence_dir} ${evidence_dir}_prev
  fi

  mkdir ${evidence_dir}
  fdisk -l > ${evidence_dir}/fdisk.out
  blkid > ${evidence_dir}/blkid.out
  lvs > ${evidence_dir}/lvs.out
  lvscan > ${evidence_dir}/lvscan.out
  ip addr show > ${evidence_dir}/ip_addr.out
  ip route show > ${evidence_dir}/ip_route.out
  cat /proc/mounts > ${evidence_dir}/mount.out
  cat /proc/cmdline > ${evidence_dir}/cmdline.out
  cat /etc/fstab > ${evidence_dir}/fstab.out
  blkid -s UUID -o value /dev/${_bootpart} > ${evidence_dir}/bootuuid.out
  blkid -s UUID -o value /dev/${_swappart} > ${evidence_dir}/swapuuid.out
  rpm -qa > ${evidence_dir}/rpm.out
  df -h > ${evidence_dir}/dfh.out
  nmcli con show > ${evidence_dir}/nmcli.out

  write_message "INFO" "Evidence gathered"
}


function check_system(){
########################################################################################
#
#   Function for performing preliminary checks
#
########################################################################################
  write_message "INFO" "Checking OS version."
  cur_ver=$(cat /etc/redhat-release | awk '{print $6}')
  cur_maj_ver=${cur_ver:0:1}
  cur_min_ver=${cur_ver:2:3}
  echo "OS Version before: ${cur_ver}" >> ${log_path}/${state_file}

  if [[ ${cur_maj_ver} -ne 8 ]]; then
    write_message "ERROR" "System is not RHEL 8! Exitting..."
    exit 1
  else
    write_message "OK" "Server is RHEL 8"
  fi

  write_message "INFO" "Checking server environment"
  environment=$(grep Env /etc/motd | awk '{print $1}')
  case ${environment} in
    "Production")
      satellite_env="prod"
      ;;
    "Consolidation")
      satellite_env="cons"
      ;;
    *)
      satellite_env="dev"
      ;;
  esac
  write_message "OK" "Target satellite environment is: ${satellite_env}"
  echo "Satellite env: ${satellite_env}" >> ${log_path}/${state_file}

  write_message "INFO" "Verifying free space in / and /var"
  root_used_perc=$(df -h --output=pcent / | tail -n +2 | sed 's/%//g')
  if [[ ${root_used_perc} -ge 60 ]]; then
    write_message "ERROR" "/ filesystem used in more than 60%!"
    write_message "ERROR" "Please extend filesystem and restart the script."
    exit 2
  else
    write_message "OK" "/ filesystem has enough space."
  fi

  var_used_perc=$(df --output=pcent /var | tail -n +2 | sed 's/%//g')
  if [[ ${var_used_perc} -ge 60 ]]; then
    write_message "ERROR" "/var filesystem used in more than 60%!"
    write_message "ERROR" "Please extend filesystem and restart the script."
    exit 2
  else
    write_message "OK" "/var filesystem has enough space."
  fi

  write_message "INFO" "Checking if server is a SAP"
  sap_exists=$(systemctl list-unit-files | grep -i sapinit)
  if [[ ! -z ${sap_exists} ]]; then
    write_message "OK" "Server is a SAP."
    server_type="SAP"
    echo "Server type: SAP" >> ${log_path}/${state_file}
  else
    write_message "OK" "Server is not SAP"
    server_type="normal"
    echo "Server type: normal" >> ${log_path}/${state_file}
  fi

  write_message "INFO" "Checking if MFT services are running (codirect)"
  mft_exists=$(systemctl list-unit-files | grep -i mft | grep service)

  if [[ ! -z ${mft_exists} ]]; then
    write_message "OK" "MFT (Codirect) Services found."
    echo "Codirect: yes" >> ${log_path}/${state_file}
  else
    write_message "OK" "No MFT (Codirect) services found."
    echo "Codirect: no" >> ${log_path}/${state_file}
  fi

  write_message "INFO" "Checking for mounted NFS fshares"
  nfs_exists=$(grep nfs /proc/mounts | grep -v rpc)

  if [[ ! -z ${nfs_exists} ]]; then
    write_message "OK" "NFS shares mounted on the server"
    echo "NFS: yes" >> ${log_path}/${state_file}
  else
    write_message "OK" "No NFS shares mounted"
    echo "NFS: no" >> ${log_path}/${state_file}
  fi

  write_message "INFO" "Checking for 7to8 leapp"
  leapp_packages="leapp-upgrade-el7toel8 python2-leapp"
  leapp7to8_exists=$(rpm -qa | egrep "leapp-upgrade-el7toel8|python2-leapp")

  if [[ ! -z ${leapp7to8_exists} ]]; then
    write_message "INFO" "Leap7to8 packages found... removing"
    echo "Leap7to8: yes" >> ${log_path}/${state_file}
    dnf config-manager --save --setopt exclude=''
    dnf remove ${leapp_packages} -y
    leapp7to8_exists=$(rpm -qa | egrep "leapp-upgrade-el7toel8|python2-leapp")
    if [[ ! -z ${leapp7to8_exists} ]]; then        
        write_message "CRITICAL" "${leapp_packages} could not be removed!"
        write_message "WARNING" "Please remove manually in second console before proceeding..."
        read -p "Pres [ENTER] to continue..."
    fi
    write_message "OK" "Leap7to8 packages removed!"
  else
    write_message "OK" "Leap7to8 packages not found"
    echo "Leap7to8: no" >> ${log_path}/${state_file}
  fi
}


function disable_nfs(){
########################################################################################
#
#   Function for disabling NFS shares
#
#########################################################################################

    write_message "INFO" "NFS mounted filesystems found."
    write_message "INFO" "Stopping NFS target..."
    systemctl stop nfs-client.target
    write_mark
    systemctl status nfs-client.target
    write_mark
    grep -q
    write_message "INFO" "Modifying fstab..."
    if [[ -f /etc/fstab.orig ]]; then
      mv /etc/fstab.orig /etc/fstab.orig.bak
    fi
    cp -p /etc/fstab /etc/fstab.orig

    sed -i 's/\(.*\s*nfs.*\s*.*\)/\##OFFLINE-BY-OSUPGRADE##\1/g' /etc/fstab
    write_message "WARNING" "fstab modified, please verify before proceeding"
    write_mark
    diff -y /etc/fstab /etc/fstab.orig
    write_mark
    read -p "Press [ENTER] to continue..."

    write_message "INFO" "Unmounting NFS filesystems..."
    for filesystem in $(cat /proc/mounts | grep nfs | awk '{print $2}'); do
      write_message "INFO" "Unmounting ${filesystem}..."
      umount ${filesystem}
      rc=$?
      if [[ $rc -ne 0 ]]; then
        write_message "CRITICAL" "${filesystem} could not be unmounted!"
        write_message "WARNING" "Please unmount manually in second console before proceeding..."
        read -p "Pres [ENTER] to continue..."
      fi
    done
    write_message "INFO" "NFS filesystems unmounted. Please verify"
    write_mark
    cat /proc/mounts
    write_mark
    read -p "Press [ENTER] to continue..."

}
function enable_nfs(){
#########################################################################################
#
# Function for reenabling NFS shares
#
#########################################################################################
  grep -q nfs /etc/fstab
  rc=$?

  if [ ${rc} -ne 0 ]; then
    write_message "INFO" "DEBUG: No NFS entries found in /etc/fstab"
  else
    write_message "INFO" "Restoring original fstab..."
    cp -p /etc/fstab.orig /etc/fstab
    sed -i 's/##OFFLINE-BY-OSUPGRADE##//g'
    write_message "WARNING" "Please verify fstab"
    write_mark
    diff -y /etc/fstab /root/preupg-evidence/fstab.out
    write_mark
    read -p "Press [ENTER] to continue..."
    write_message "INFO" "Mounting NFS filesystems..."
    mount -a
    rc=$?
    if [ $rc -ne 0 ]; then
      write_message "CRITICAL" "Filesystems could not be mounted!"
      write_message "CRITICAL" "Please check and mount manually in second console."
      read -p "Press [ENTER] to continue..."
    fi
     write_message "INFO" "NFS filesystems mounted."
  fi
}

function stop_services(){
#####################################################################################
#
#   Function for stoping services that could interfere with upgrade.
#   Preprogrammed list of services that need to be stopped:
#   - all dsmcad services
#   - puppet (via puppet agent --disable)
#   - sapinit (if SAP server)
#   - sap (if SAP server)
#
######################################################################################
#TO DO dodanie serwisów codirecta
  write_message "INFO" "Disabling Puppet..."
  puppet agent --disable "Server upgrade in progress"
  echo "Puppet: off" >> ${log_path}/${state_file}

  write_message "INFO" "Checking for TSM service"
  tsm_exists=$(systemctl list-unit-files | grep dsm | grep service)

  if [[ ! -z ${tsm_exists} ]]; then
    write_message "INFO" "TSM service found."
    echo "TSM_service: yes" >> ${log_path}/${state_file}
  else
    write_message "INFO" "No TSM service."
    echo "TSM_service: no" >> ${log_path}/${state_file}
  fi

  if [[ ! -z ${tsm_exists} ]]; then
    write_message "INFO" "Disabling TSM services"
    tsm_service=(dsmcad)
    systemctl disable --now ${tsm_service}
    echo "Service: ${tsm_service}: disabled" >> ${log_path}/${state_file}
  fi

  write_message "INFO" "Disabling TSM services"
  for dsm_svc in $(systemctl list-unit-files | grep dsm | grep service); do
    systemctl stop ${dsm_svc}
    systemctl disable ${dsm_svc}
    echo "Service: ${dsm_svc}: disabled" >> ${log_path}/${state_file}
  done

  if [[  ${server_type} == "SAP" ]]; then
    write_message "INFO" "Disabling SAP services"
    sap_services=(sap sapinit)
    for sap_svc in ${sap_services}; do
        systemctl stop ${sap_svc}
        systemctl disable ${sap_svc}
        echo "Service: ${sap_svc}: disabled" >> ${log_path}/${state_file}
    done
  fi

  write_message "OK" "Services stopped."
}

function prepare(){
#####################################################################################
#
#   Function for making necessary preparations for upgrade and performing prechecks
#
#####################################################################################

#update-crypto-policies --set LEGACY
  write_message "INFO" "Performing preliminary checks"
  check_system

  write_message "INFO" "Gathering preupgrade evidence"
  gather_evidence

  write_message "INFO" "Setting icinga downtime"
  /usr/isbs/bin/send_to_icinga --setdowntime --date now --duration 240 --author IH-IOIS-MSP --hostname $(hostname) --comment "Server upgrade in progress" 2>&1 > /dev/null

  write_message "INFO" "Installing required packages"
  install_requirements

  nfs_exists=$(grep "NFS" ${log_path}/${state_file} | awk '{print $2}')
  if [[ ${nfs_exists} == "yes" ]]; then
    disable_nfs
  fi

  write_message "INFO" "Stopping unnecessary services..."
  stop_services

  write_message "INFO" "checking for /daten"
  _datenexist=0
  if [ -L /daten ]; then
    _datenexist=1
    write_message "INFO" "Found /daten link. Removing"
    echo "daten_link: removed" >> ${log_path}/${state_file}
    rm -fv /daten
  else
    write_message "OK" "No /daten link found..."
  fi

  write_message "INFO" "checking for /data"
  _dataexist=0
  if [ -L /data ]; then
    _dataexist=1
    write_message "INFO" "Found /data link. Removing"
    echo "data_link: removed" >> ${log_path}/${state_file}
    rm -fv /data
  else
    write_message "OK" "No /data link found..."
  fi

  write_message "INFO" "Updating server to latest RHEL 8 version"

  dnf -y update
  rc=$?

  if [[ ${rc} -ne 0 ]]; then
    write_message "ERROR" "Can't update server!"
    write_message "ERROR" "Verify in second console before continuing!"
    read -p "Press [ENTER] to continue..."
  else
    write_message "OK" "System is up to date"
  fi

  # Checking if new kernel is in place
  cur_kernel_ver=$(uname -r)
  new_kernel_ver=$(rpm -q kernel | sort | tail -n 1)

  if [[ ${cur_kernel_ver} != ${new_kernel_ver:7} ]]; then
    write_message "WARNING" "New kernel detected!"
    write_message "WARNING" "Current Kernel version: ${cur_kernel_ver}"
    write_message "WARNING" "Newest kernel installed: ${new_kernel_ver}"
    write_message "WARNING" "Please reboot system to accomodate new kernel!"
  else
    write_message "OK" "Kernel didn't change."
  fi
  write_message "INFO" "Updating crypto policies"
  update-crypto-policies --set LEGACY
}

function upgrade(){
#####################################################################################
#
#   Function for performing inplace upgrade using leapp
#
#####################################################################################
  write_message "INFO" "Preparing to leapp..."
  curl https://sat-capsule-bs/pub/leapp-data${leapp_data_ver}.tar.gz -o /tmp/leapp-data${leapp_data_ver}.tar.gz
  tar -zxf /tmp/leapp-data${leapp_data_ver}.tar.gz -C /etc/leapp/files/
  subscription-manager unregister
  subscription-manager register --activationkey=ak-upgrade-rhel8-rhel9-dev --org vwfs --force
  subscription-manager release --unset
  subscription-manager repos --disable=rhel-8-for-x86_64-supplementary-rpms --disable=rhel-8-server-extras-rpms --disable=rhel-8-server-optional-rpms --disable=rhel-server-rhscl-8-rpms
  yum versionlock clear
  sed -i 's/^MACs/#MACs/' /etc/ssh/sshd_config

  write_message "INFO" "Checking for pata_acpi module..."
  lsmod | grep -q pata_acpi
  rc=$?
  if [[ ${rc} -eq 0 ]]; then
    write_message "INFO" "Removing pata_acpi modile..."
    rmmod pata_acpi
  else
    write_message "INFO" "pata_acpi module not load module..."
  fi

  write_message "INFO" "Running preliminary run of leapp preupgrade..."
  write_message "WARNING" "Inhibitor in this stage is normal! No action needed when inhibitor is found!"
  write_message "WARNING" "Don't stop script if inhibitor found!"

  leapp preupgrade --channel=e4s --target=${target_ver}

  write_message "INFO" "Correcting answerfile..."
  leapp answer --section remove_pam_pkcs11_module_check.confirm=True

  write_message "INFO" "Running secondary run of leapp preupgrade."
  write_message "INFO" "Inhibitors in this step must be investigated!"

  leapp preupgrade --channel=e4s --target=${target_ver}
  rc=$?
  case ${rc} in
  2)
    write_message "WARNING" "Debug: return code 2"
    ;;
  1)
    write_message "WARNING" "Inhibitors found. Please use secondary console to correct."
    read -p "Press [ENTER] to continue..."
    write_message "INFO" "Rerunning leapp answer"
    leapp answer --section remove_pam_pkcs11_module_check.confirm=True
    write_message "INFO" "Rerunning leapp preupgrade"
    leapp preupgrade --channel=e4s --target=${target_ver}
    ;;
  esac

  write_message "INFO" "Starting upgrade..."
  leapp upgrade --channel=e4s --target=${target_ver}

  write_message "INFO" "Verification of /boot content"
  write_message "WARNING" "Please verify if upgrade kernel and upgrade initramfs are present."
  write_mark
  ls /boot
  write_mark
}

#function verify_after(){
######################################################################################
#
# Function for system verification
# Verification should be based on state file
#
######################################################################################
# dodać sprawdzanie stanu serwisów MFT i SAP po reboocie
# output do test result
#}

function rollback(){

  subscription-manager unregister
  subscription-manager register --activationkey=ak-rhel8-generic-dev --org vwfs --force
}

function post(){
######################################################################################
#
#  Function for post-upgrade checks and task
#    - enabling puppet and services if necessary
#    - registering server to target content view
#    - mounting NFS filesystems
#    - final update of system to latest version of OS
#
######################################################################################

  #check server type in state file
  #restore _datenexist=1/_dataexist=1
  server_type=$(grep "Server type" ${log_path}/${state_file} | awk -F ':' '{ print $2 }')
  codirect=$(grep "Codirect" ${log_path}/${state_file} | awk -F ':' '{ print $2 }')
  nfs_ex=$(grep "NFS" ${log_path}/${state_file} | awk -F ':' '{print $2}')
  satellite_env=$(grep "Satellite" ${log_path}/${state_file} | awk -F ':' '{print $2}')
  dsm_svcs=$(grep)

  write_message "INFO" "Reregistering server to satellite"
  subscription-manager unregister
  subscription-manager clean
  if [ ${server_type} = "normal" ]; then
    activation_key="ak-rhel9-generic-${satellite_env/ /}"
    echo ${activation_key}
  elif [ ${server_type} = 'SAP' ]; then
    activation_key="ak-rhel90-e4s-${satellite_env}"
  fi

  write_message "INFO" "Registering server with ${activation_key}"
  subscription-manager register --activationkey=${activation_key} --org vwfs --force
  subscription-manager release --set=9
  write_message "INFO" "Updating OS to latest version."
  dnf clean all
  dnf -y update
  rc=$?

  if [[ ${rc} -ne 0 ]]; then
    write_message "ERROR" "System update failed. Please check in second console"
  fi

  if [[ ${nfs_ex} == 'yes' ]]; then
    enable_nfs
  fi

  if [[ ${server_type} == 'SAP' ]]; then
    write_message "INFO" "Enabling SAP services"
    for svc in sap sapinit; do
      systemctl enable ${svc}
    done
    write_message "INFO" "SAP services started."
  fi

  if [[ ${codirect}  == "yes" ]]; then
    write_message "INFO" "Checking if libtirpc is installed"
    libtirpc_inst=$(rpm -q libtirpc)

    if [[ -z ${libtirpc_inst} ]]; then
      write_message "INFO" "Installing libtirpc"
      dnf -y install libtirpc
    fi

    write_message "INFO" "Linking libtirpc for codirect"
    ln -s /lib64/libtirpc.so.3 /lib64/libtirpc.so.1

    write_message "INFO" "Starting MFT services"
    for mft_svc in $(systemctl list-unit-files | grep -i mft | grep service | awk '{print $1}'); do
      systemctl enable ${mft_svc}
    done
  fi
  write_message "INFO" "Restore crypto policies"
  update-crypto-policies --set DEFAULT:SHA1  

  write_message "INFO" "Enabling puppet"
  puppet agent --enable

  write_message "INFO" "Running puppet"
  puppet agent -t

  write_message "INFO" "Server upgrade finished"
  write_mark
  echo "Please check icinga for errors"
  echo "Please reboot system to verify system is running correctly"

}

case "$1" in
prepare)
  prepare
  ;;
upgrade)
  upgrade
  ;;
post)
  post
  ;;
verify_after)
  verify_after
  ;;
rpmreport)
  rpmreport
  ;;
rollback)
  rollback
  ;;
*)
  usage
  exit 1
  ;;
esac

exit 0
