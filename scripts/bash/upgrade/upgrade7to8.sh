#!/bin/bash

###########################################################################################
#
#  upgrade7to8.sh
#
#  Script for performing in-place upgrades from RHEL 7.9 to RHEL 8.X
#  Script converts all OS filesystems from ext3/4 to xfs
#  Script converts partition table on primary disk from MBR to GPT
#
#  Authors:  Rafał Bera (KYNDRYL)
#            Paweł Kurzydłowski (KYNDRYL)
#
#
#  Version: 1.0
#
#
##########################################################################################

printok() {
  echo "[01;32m$1[0m"
}
printwarn() {
  echo "[01;33m$1[0m"
}
printcrit() {
  echo "[01;31m$1[0m"
}
printinfo() {
  echo "[01;34m$1[0m"
}
printmark() {
  echo "[01;36m-----------------------------------------------------------------[0m"
}

# caclulating constants required for upgrade process

_host=$(hostname -s)
_hostnum=${_host:4:4}
_pridisk=sda
_bootpart=sda1
_swappart=sda2
_curver=$(lsb_release -s -r)
_curmajver=${_curver:0:1}
_curkernelver=$(uname -r)
_pvpart=$(pvs --no-headings -S vg_name=system${_hostnum} -o pv_name | grep sda | sed 's/.*\///' | xargs)
_sysvg="system${_hostnum}"
_bootsize=$(lsblk --nodeps --noheadings -b --output SIZE /dev/${_bootpart})
_swapsize=$(lsblk --nodeps --noheadings --output SIZE /dev/${_swappart})
_bootused=$(df -Pk /boot | grep "boot$" | awk '{print $3}')
_tmpfree=$(df -Pk /tmp | grep "tmp$" | awk '{print $4}')
_partcount=$(cat /proc/partitions | grep -c ${_pridisk})
_statefile=/root/preupg-evidence/upgrade.state
_targetver=8.6
#_leappdataver=22

rpmreport() {
  ###################################################################################################
  # Function for reporting non-Red Hat packages installed on the servers to inform customer.
  # List of packages needs to be sent to the requestor and server owners before performing upgrade.
  ###################################################################################################

  printinfo "Gathering data..."
  mkdir rpm-evi
  rpm -qa --qf "%-30{NAME} - %-10{VERSION} - %{VENDOR}\n" | egrep -v "Red Hat|gpg-pubkey|nagios|Puppet|BESClient|BESAgent|Icinga"
  printinfo "Please send list of non-Red Hat packages to requestor and server owners."
} # /rpmreport

prepare78() {
  ##################################################################################################
  # Function for generating evidence before performing upgrade.
  #################################################################################################

  # basic check for preparation:

  if [ ${_curmajver} -ne 7 ]; then
    printcrit "Script requires RHEL 7.X"
    exit 1
  fi

  printinfo "== Set maintenance mode in icinga:"
  printinfo "     Run from second console: "
  printwarn "     /usr/isbs/bin/send_to_icinga --setdowntime --date now --duration 240 --author IH-IOIX-MSP --hostname $(hostname) --comment WaWo 2>&1 > /dev/null"
  read -p "Press [Enter] to continue..."

  printinfo "== Set temporary root password on server for emergency access."
  read -p "Press [ENTER] to continue..."

  printinfo "== Create rear backup"
  printinfo "     In second console please run following command:"
  printwarn "            rear mkrescue"
  printinfo "     If TSM is not configured, run it anyway..."
  read -p "Press [Enter] to continue..."

  if [ ! -d /root/preupg-evidence ]; then
    printinfo "Preparing evidence (/root/preupg-evidence)"
    mkdir /root/preupg-evidence
    fdisk -l >/root/preupg-evidence/fdisk.out
    blkid >/root/preupg-evidence/blkid.out
    lvs >/root/preupg-evidence/lvs.out
    lvscan >/root/preupg-evidence/lvscan.out
    ip addr show >/root/preupg-evidence/ip_addr.out
    ip route show >/root/preupg-evidence/ip_route.out
    cat /proc/mounts >/root/preupg-evidence/mount.out
    cat /proc/cmdline >/root/preupg-evidence/cmdline.out
    cat /etc/fstab >/root/preupg-evidence/fstab.out
    blkid -s UUID -o value /dev/${_bootpart} >/root/preupg-evidence/bootuuid.out
    blkid -s UUID -o value /dev/${_swappart} >/root/preupg-evidence/swapuuid.out
    rpm -qa >/root/preupg-evidence/rpm.out
    df -h >/root/preupg-evidence/dfh.out
    touch ${_statefile}
  fi

  printinfo "Evidence gathered. Please check."
  ls -l /root/preupg-evidence
  read -p "Press [ENTER] to continue..."

  printinfo "Disabling puppet agent"
  puppet agent --disable "Server upgrade in progress."
  echo "puppet: disabled" >> ${_statefile}

  check_root=$(df -h / | sed 1d | awk '{print $5}' | sed -e '$s/%$//g')
  if [ ${check_root} -ge 60 ]; then
    printwarn "Lack of space in /. Please extend this FS manually"
  else
    printinfo "Space / checked. OK"
  fi

  check_var=$(df -h /var | sed 1d | awk '{print $5}' | sed -e '$s/%$//g')
  if [ ${check_var} -ge 60 ]; then
    printwarn "Lack of space in /var. Please extend this FS manually"
  else
    printinfo "Space /var checked. OK"
  fi 

  read -p "Press [ENTER] to continue..."

  if [ -L /daten ]; then
    printwarn "/daten exist. Creating check_daten file in /"
    touch /check_daten
    echo "daten: yes" >> ${_statefile}

    check_daten=$(ls / | grep check_daten)
    printinfo ${check_daten} "created. OK."
  else
    printinfo "Daten link doesnt exists. Nothing to do"
    echo "daten: no" >> ${_statefile}
  fi
  read -p "Press [ENTER] to continue..."

  if [ -L /data ]; then
    printwarn "/data exist. Creating check_daten file in /"
    touch /check_data
    echo "data: yes" >> ${_statefile}

    check_data=$(ls / | grep check_data)
    printinfo ${check_data} "created. OK."
  else
    printinfo "Data link doesnt exists. Nothing to do"
    echo "data: no" >> ${_statefile}
  fi
  read -p "Press [ENTER] to continue..."
  printinfo "Verifying if Codirect services exist"
  systemctl -t service | grep MFT
  rc=$?

  if [[ ${rc} -eq 0 ]]; then
    printinfo "MFT Services running!"
    echo "mft: yes" >> ${_statefile}
  else
    echo "mft: no" >> ${_statefile}
  fi

  printcrit "Please shutdown server and backup vmdk file in vcenter before proceeding!"
  vmdkbkp=0
  while [[ ${vmdkbkp} -eq 0 ]]; do
    read -p "Was vmdk file backed up? (yes/no)" ans
    case ${ans} in
    'yes')
      vmdkbkp=1
      ;;
    'no')
      printcrit "Please shutdown the server and backup vmdk in vcenter and rerun the script!"
      exit 3
      ;;
    *)
      printwarn "Please answer yes or no."
      ;;
    esac
  done

  printinfo "Removing unused kernels"
  curkern=$(uname -r)
  for a in $(rpm -q kernel); do
    if [ ! ${a} == "kernel-${curkern}" ]; then
      echo "Removing ${a}..."
      rpm -e "${a}"
    fi
  done
  read -p "Press [Enter] to continue..."

  printinfo "Enabling extras and optional repositories"

  subscription-manager repos --enable=rhel-7-server-extras-rpms
  subscription-manager repos --enable=rhel-7-server-optional-rpms

  printinfo "Installing required software"
  epelstatus=$(yum repolist all | grep epel | awk '{print $3}' | sed 's/://g')
  if [[ ${epelstatus} != "enabled" ]]; then
    subscription-manager repos --enable=vwfs_vwfs_oss_epel7
  fi
  yum install -y gdisk dosfstools fstransform rsync
  read -p "Press [Enter] to continue..."

  printinfo "Updating server latest version"
  yum update -y

  newestkernel=$(rpm -q kernel | tail -n 1)
  if [[ ${_curkernelver} != ${newestkernel:7} ]]; then

    echo "New kernel detected!"
    echo "Current running kernel: ${_curkernelver}"
    echo "Newest installed kernel: ${newestkernel:7}"
    printwarn "Please reboot the server before proceeding to ensure latest kernel usage!"
  else

    echo "Kernels seems to be the same"
    echo "New kernel: ${newestkernel:7}"
    echo "Current kernel: ${_curkernelver}"

  fi

  printmark
  printinfo "== Initial evidence finished. Next step:"
  printcrit "        /root/upgrade7to8.sh fsconvert"
} #/prepare78

ptconvert() {
  ###########################################################################################
  # Function for converting partition table from MBR to GPT format
  ###########################################################################################

  printinfo "Starting preconversion checks..."

  printinfo "Veryfing partitions" # Only informative  check. Temporary disk is attached after converting filesystems to xfs
  if [ $(vgs --no-headings -o pv_count system${_hostnum}) -ne 1 ]; then
    printok "INFO: Volume group system${_hostnum} has more than one PV. No action needed!"
  fi

  if [ "${_bootsize}" -le 500000000 ]; then # Verification of /boot size. Required > 500 MB
    printcrit "Error: /boot size not sufficient"
    exit 1
  fi

  if [ "${_bootpart}" != "sda1" -a "${_swappart}" != "sda2" -a "${_pvpart}" != "sda3" -a ${_partcount} -ne 4 ]; then
    printcrit "Error: Non standard partitioning"
    exit 1
  fi
  printinfo "Checking if dosfstools was installed"
  rpm -q --quiet dosfstools
  rc=$?
  
  if [ ${rc} -ne 0 ]; then
    printwarn "dosfstools not found. Installing"
    yum install -y dosfstools
  else
    printok "dosfstools found"
  fi 
  
  printinfo "Checking if parted is installed"
  rpm -q --quiet parted
  rc=$?

  if [[ ${rc} -ne 0 ]]; then
    printwarn "parted not found. Installing"
    yum install -y parted
  else
    printok "parted installed"
  fi
  
  printok "Checks OK."

  printinfo "Creating backup of /boot"
  if [ ${_bootused} -gt ${_tmpfree} ]; then
    printcrit "Error: No space for /boot backup"
    exit 1
  else
    if [ ! -d /tmp/boot ]; then
      cp -pr /boot /tmp/
      if [ $? -ne 0 ]; then
        printcrit "Error: Backup for /boot failed !!!"
        exit 1
      fi
    fi
  fi
  read -p "Press [Enter] to continue..."

  read -p "Enter a name for the temporary disk (e.g. sdb) and press [Enter]: " tmpdiskans
  if [[ -z tmpdisk ]]; then
    printwarn "No disk provided!"
    read -p "Please provide a name of the temporary disk and press [ENTER]: " tmpdiskans
    if [[ -z ${tmpdiskans}} ]]; then
      printcrit "No temporary disk provided! Exitting..."
      exit 1
    fi
  fi


  tmpdisk=$(echo ${tmpdiskans} | sed 's/\(.*\)\(sd[a-z]\)/\2/g')
  printok "Using /dev/${tmpdisk} as temporary disk"

  read -p "Press [ENTER] to continue..."

  printinfo "Disabling swap and removing /dev/${_swappart} partition"
  printmark
  swapon -s
  parted -s /dev/${_pridisk} print
  printmark
  swapoff /dev/${_swappart}
  swapuuid=$(blkid -s UUID -o value /dev/${_swappart})

  parted -s /dev/${_pridisk} rm 2
  partx -d /dev/${_pridisk}
  partprobe /dev/${_pridisk}
  printmark
  swapon -s
  parted -s /dev/${_pridisk} print
  printmark
  printwarn "Verify the output before and after removal of partitions!"
  read -p "Press [Enter] to continue..."

  printinfo "Unmounting /boot filesystem and removing /dev/${_bootpart} partition"
  printmark
  parted -s /dev/${_pridisk}
  df -k /boot
  printmark
  umount /boot
  if [ $? -ne 0 ]; then
    printcrit "Error: Unmounting of /boot failed"
    exit 1
  fi
  bootuuid=$(blkid -s UUID -o value /dev/${_bootpart}) # partition UUID will be used for restoring /boot partitions.

  parted -s /dev/${_pridisk} rm 1
  partx -d /dev/${_pridisk}
  partprobe /dev/${_pridisk}
  printmark
  df -k /boot
  parted -s /dev/${_pridisl}
  printmark
  printwarn "Verify the output before and after removing of partitions!"
  read -p "Press [Enter] to continue..."

  printinfo "Moving ${_pridisk} to temporary disk"
  disksize=$(cat /sys/block/${_pridisk}/size)
  pvstart=$(cat /sys/block/${_pridisk}/${_pvpart}/start)
  pvsize=$(cat /sys/block/${_pridisk}/${_pvpart}/size)
  pvend=$((pvstart + pvsize - 1))

  #  printwarn "Please attach new temporary disk with $((pvsize*512/2**30+1))GB size at least"

  printinfo "Verification of temporary PV"
  printmark
  pvs -S vg_name=system${_hostnum} | grep ${tmpdisk}
  printmark
  printwarn "Verify output above if PV is 100% free"
  read -p "Press [ENTER] to continue..."

  printinfo "Moving PV data to temporary disk"
  pvmove -A y --atomic --reportformat=basic -i 10 /dev/${_pvpart}
  printmark
  pvscan
  read -p "Press [Enter] to continue..."
  printinfo "Releasing original PV (${_pvpart}) "
  pvscan
  printmark
  vgreduce system${_hostnum} /dev/${_pvpart}
  pvremove /dev/${_pvpart}
  printmark
  pvscan
  read -p "Press [Enter] to continue..."
  printinfo "Removing original PV partition "
  printmark
  parted -s /dev/${_pridisk} print
  printmark
  pvscan
  parted -s /dev/${_pridisk} rm 3
  partx -d /dev/${_pridisk}
  partprobe /dev/${_pridisk}
  printmark
  parted -s /dev/${_pridisk} print
  printmark
  printwarn "VERIFY Output above"
  read -p "Press [enter] to continue..."

  printinfo "Converting MBR to GPT"
  parted -s /dev/${_pridisk} print
  printmark

  parted -s /dev/${_pridisk} mklabel gpt
  partprobe /dev/${_pridisk}
  printmark
  parted -s /dev/${_pridisk}
  printmark
  read -p "Press [Enter] to continue..."

  printinfo "Creating EFI, BOOT and ROOT partitions"
  printmark

  # Creating partition for EFI, /boot, and root LVM
  parted -a opt -s /dev/${_pridisk} \
    mkpart efi fat16 0% 50M \
    set 1 boot on \
    mkpart bootpart ext4 50M 550M \
    mkpart rootpart ext4 550M 100% \
    set 3 lvm on
 
  partx -a /dev/${_pridisk}
  printmark
  parted -s /dev/${_pridisk} print
  printwarn "Verify the output before and after adding of partitions"
  read -p "Press [Enter] to continue..."

  printinfo "Creating and mounting EFI and BOOT filesystems"
  grep boot /etc/fstab
  df -k /boot /boot/efi
  swapon -s
  printmark
  mke2fs -t ext4 -U ${bootuuid} /dev/sda2         # recreating /boot partition using previously saved UUID
  sed -i 's/boot.*ext[23]/boot\text4/' /etc/fstab # correcting fstab entry for /boot (ext2 to ext4)
  printinfo "/boot partition created. Mounting..."
  read -p "Press [ENTER] to continue..."
  mount /boot
  rc=$?
  if [[ $rc -ne 0 ]]; then
    printmark
    printcrit "/boot not mounted correctly! Please check and mount manually in second console!"
    printmark
  fi
  printmark
  mount | grep boot
  printmark
  printcrit "Please verify /boot is mounted correctly before continuing!"
  read -p "Press [ENTER] to continue..."

  mkfs -t vfat /dev/sda1
  efiuuid=$(blkid -s UUID -o value /dev/sda1)
  sed -i "/boot/a UUID=${efiuuid}\t/boot/efi\tvfat\tdefaults\t1\t2" /etc/fstab
  mkdir -p /boot/efi
  rm -f /etc/modprobe.d/vfat.conf
  depmod -a
  mount /boot/efi
  rc=$?
  if [[ $rc -ne 0 ]]; then
    printcrit "/boot/efi not mounted correctly! Please check and mount manually in second console!"
  fi
  printmark
  printmark
  grep boot /etc/fstab
  df -kP /boot /boot/efi
  swapon -s
  printmark
  mount | grep boot
  printmark
  printmark
  printcrit "Verify the output before and after adding of partitions"
  read -p "Press [Enter] to continue..."

  printinfo "Moving ROOT to original disk..."
  pvcreate /dev/sda3
  vgextend system${_hostnum} /dev/sda3
  printmark
  parted -s /dev/${_pridisk} print
  pvscan
  read -p "Press [Enter] to continue..."

  printinfo "Moving data to original PV (/dev/${tmpdisk}1 -> /dev/${_pvpart})"
  pvscan
  printmark
  pvmove -A y --atomic --reportformat=basic -i 10 /dev/${tmpdisk}
  printmark
  pvscan
  read -p "Press [Enter] to continue..."
  printinfo "Releasing temporary disk ${tmpdisk}"
  parted -s /dev/${tmpdisk} print
  pvscan
  printmark
  vgreduce system${_hostnum} /dev/${tmpdisk}
  pvremove /dev/${tmpdisk}
  printmark
  parted -s /dev/${tmpdisk} print
  pvscan
  read -p "Please detach temporary disk and press [Enter] to continue..."

  printinfo "Creating swap_lv..."
  lvcreate -L ${_swapsize} -n swap_lv system${_hostnum}
  mkswap -U ${swapuuid} /dev/system${_hostnum}/swap_lv
  swapon -a
  printmark
  swapon -s
  printmark
  read -p "Press [Enter] to continue..."

  printinfo "Copying backup of boot to the new partitions"
  ls /boot
  printmark
  cp -pr /tmp/boot/* /boot
  printmark
  ls /boot
  read -p "Press [Enter] to continue..."

  printinfo "Installing EFI software"
  yum install -y efibootmgr grub2-efi-x64 grub2-tools-efi
  read -p "Press [Enter] to continue..."

  printinfo "Creating grub.cfg"
  grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
  sed -i 's/linux16/linuxefi/' /boot/efi/EFI/redhat/grub.cfg
  sed -i 's/initrd16/initrdefi/' /boot/efi/EFI/redhat/grub.cfg
  read -p "Press [Enter] to continue..."

  printmark
  printinfo "== Partition table covertion finished."
  printinfo "   Please perform following actions:"
  printinfo "    - Verify /etc/modprobe.d/vfat.conf was removed"
  printinfo "    - Poweroff the server"
  printinfo "    - Set EFI as Firmware and Force EFI setup in vm options in vCenter"
  printinfo "       - Start VM and configure boot options from vCenter console."
}

upgrade78() {

  #############################################################################################
  #
  # Function for performing final preparations and triggering the upgrade using leapp tool
  #
  #############################################################################################

  printinfo "Stopping puppet service..."
  systemctl stop puppet

  printinfo "Installing leapp..."
  subscription-manager repos --enable=rhel-7-server-extras-rpms
  rc=$?
  if [[ $rc -ne 0 ]]; then
    printcrit "extras repository not enabled! Please enable in secondary console!"
    printinfo "    subscription-manager repos --enable=rhel-7-server-extras-rpms"
    read -p "Press [ENTER] to continue..."
  fi
  printmark
  yum repolist all | grep extra
  printmark
  read -p "Press [ENTER] to continue..."

  yum -y install leapp leapp-upgrade-el7toel8
  read -p "Press [Enter] to continue..."

  printinfo "Verification of /boot directory contents"
  printmark
  ls /boot
  printmark
  read -p "Press [ENTER] to continue..."

  printinfo "Checking if there are mounted nfs..."
  printmark
  grep -i nfs /proc/mounts
  rc=$?
  printmark
  if [[ ${rc} -ne 0 ]]; then
    printinfo "No NFS mounts found."
    echo "nfs: no" >> ${_statefile}
  else
    echo "nfs: yes" >>${_statefile}
    printinfo "NFS mounted filesystems found."
    printinfo "Stopping NFS target..."
    systemctl stop nfs-client.target
    printmark
    systemctl status nfs-client.target
    printmark
    grep -q
    printinfo "Modifying fstab..."
    if [[ -f /etc/fstab.orig ]]; then
      mv /etc/fstab.orig /etc/fstab.orig.bak
    fi
    cp -p /etc/fstab /etc/fstab.orig

    sed -i 's/\(.*\s*nfs.*\s*.*\)/\##OFFLINE-BY-OSUPGRADE##\1/g' /etc/fstab # add whole comment before line.
    printwarn "fstab modified, please verify before proceeding"
    printmark
    diff -y /etc/fstab /etc/fstab.orig
    printmark
    read -p "Press [ENTER] to continue..."

    printinfo "Unmounting NFS filesystems..."
    for filesystem in $(cat /proc/mounts | grep nfs | awk '{print $2}'); do
      printinfo "Unmounting ${filesystem}..."
      umount ${filesystem}
      rc=$?
      if [[ $rc -ne 0 ]]; then
        printcrit "${filesystem} could not be unmounted!"
        printwarn "Please unmount manually in second console before proceeding..."
        read -p "Pres [ENTER] to continue..."
      fi
    done
    printinfo "NFS filesystems unmounted. Please verify"
    printmark
    cat /proc/mounts
    printmark
    read -p "Press [ENTER] to continue..."
  fi

  printinfo "checking and removing /daten"
  _datenexist=0
  if [ -L /daten ]; then
    _datenexist=1
    printinfo "Found /daten link. Removing"
    rm -fv /daten
  else
    printok "No /daten link found..."
  fi

  printinfo "checking and removing /data"
  _dataexist=0
  if [ -L /data ]; then
    _dataexist=1
    printinfo "Found /data link. Removing"
    rm -fv /data
  else
    printok "No /data link found..."
  fi

  printinfo "Preparing to leapp..."
  #curl https://sat-capsule-bs/pub/leapp-data${_leappdataver}.tar.gz -o /tmp/leapp-data${_leappdataver}.tar.gz
  #tar -zxf /tmp/leapp-data${_leappdataver}.tar.gz -C /etc/leapp/files/
  subscription-manager unregister
  subscription-manager register --activationkey=ak-upgrade-rhel7-rhel8-dev --org vwfs --force
  subscription-manager release --unset
  subscription-manager repos --disable=rhel-7-server-supplementary-rpms --disable=rhel-7-server-extras-rpms --disable=rhel-7-server-optional-rpms --disable=rhel-server-rhscl-7-rpms
  systemctl stop pxp-agent
  systemctl stop puppet
  yum versionlock clear
  sed -i 's/^MACs/#MACs/' /etc/ssh/sshd_config
  read -p "Press [Enter] to continue..."

  printinfo "Checking for pata_acpi module..."
  lsmod | grep -q pata_acpi
  rc=$?
  if [[ ${rc} -eq 0 ]]; then
    printinfo "Removing pata_acpi modile..."
    rmmod pata_acpi
  else
    printinfo "pata_acpi module not load module..."
  fi

  printinfo "Running preliminary run of leapp preupgrade..."
  printwarn "Inhibitor in this stage is normal! No action needed when inhibitor is found!"
  printwarn "Don't stop script if inhibitor found!"

  leapp preupgrade --channel=e4s --target=${_targetver}

  printinfo "Correcting answerfile..."
  leapp answer --section remove_pam_pkcs11_module_check.confirm=True
  # rc=$?
  #  if [[ ${rc} -ne 0 ]]
  #  then
  #     printwarn "Leapp answer didn't run correctly. Rerunning..."
  #     leapp answer --section remove_pam_pkcs11_module_check.confirm=True
  #     rc=$?
  #     if [[ ${rc} -ne 0 ]]
  #     then
  #         printcrit "Leapp answer didn't run correctly. Please check before continuing..."
  #         read -p "Press [ENTER] to continue..."
  #     fi
  #  fi

  printinfo "Running secondary run of leapp preupgrade."
  printinfo "Inhibitors in this step must be investigated!"

  leapp preupgrade --channel=e4s --target=${_targetver}
  rc=$?
  case ${rc} in
  2)
    printwarn "You are upgrading DB/HANA server. Setting target to 8.2"
    _targetver=8.2
    leapp preupgrade --channel=e4s --target=${_targetver}
    ;;
  1)
    printwarn "Inhibitors found. Please use secondary console to correct."
    read -p "Press [ENTER] to continue..."
    printinfo "Rerunning leapp answer"
    leapp answer --section remove_pam_pkcs11_module_check.confirm=True
    printinfo "Rerunning leapp preupgrade"
    leapp preupgrade --channel=e4s --target=${_targetver}
    ;;
  esac

  read -p "Press [Enter] to continue..."

  printinfo "Starting upgrade..."
  leapp upgrade --channel=e4s --target=${_targetver}
  read -p "Press [Enter] to continue..."

  printinfo "Verification of /boot content"
  printwarn "Please verify if upgrade kernel and upgrade initramfs are present."
  printmark
  ls /boot
  printmark
  read -p "Press [ENTER] to continue..."

}

post() {

  #############################################################################
  #
  # Function for performing post upgrade steps:
  #      - remounting of NFS filesystems
  #      - registering to target Content View in satellite
  #      - installing NetworkManager and grub2-efi-x64-modules
  #      - updating server to latest RHEL 8 minor version available from CV
  #
  #############################################################################
  printinfo "Checking and restoring /data and /daten links.."

  check_daten=$(ls / | grep check_daten)
  if [ ${check_daten} ]; then
    printwarn "/daten existed. Recreating /daten link"
    ln -s /opt/daten /daten
    printmark
    ls -l /daten
    printmark
  else
    printinfo "Daten link doesnt exists. Nothing to do" 
  fi

  check_data=$(ls / | grep check_data)
  if [ ${check_data} ]; then
    printwarn "/data existed. Recreating /data link"
    ln -s /opt/daten/ /data
    printmark
    ls -l /data
    printmark
  else
    printinfo "Data link doesnt exists. Nothing to do" 
  fi

  printinfo "copying new /etc/bashrc, /etc/profile, /etc/lvm.conf"

  cp /etc/profile /etc/profile.RHEL7
  cp /etc/bashrc /etc/bashrc.RHEL7
  cp /etc/lvm/lvm.conf /etc/lvm/lvm.conf.RHEL7
  cp /etc/profile.rpmnew /etc/profile
  cp /etc/bashrc.rpmnew /etc/bashrc
  cp /etc/lvm/lvm.conf.rpmnew /etc/lvm/lvm.conf

  printmark
  ls -l /etc | egrep "bashrc|profile"
  ls -l /etc/lvm | grep "lvm.conf"
  printmark
  read -p "Press [ENTER] to continue..."

  printinfo "Rebuilding initramfs..."
  /usr/isbs/bin/rebuild_initrds.sh
  read -p "Press [ENTER] to continue..."

  grep -q nfs /etc/fstab
  rc=$?

  if [ ${rc} -ne 0 ]; then
    printinfo "No NFS entries found in /etc/fstab"
  else
    printinfo "Restoring original fstab..."
    cp -p /etc/fstab.orig /etc/fstab
    sed -i 's/##OFFLINE-BY-OSUPGRADE##//g' #remove all occurances of this comment
    printwarn "Please verify fstab"
    printmark
    diff -y /etc/fstab /root/preupg-evidence/fstab.out
    printmark
    read -p "Press [ENTER] to continue..."
    printinfo "Mounting NFS filesystems..."
    mount -a
    rc=$?
    if [ $rc -ne 0 ]; then
      printcrit "Filesystems could not be mounted!"
      printcirt "Please check and mount manually in second console."
      read -p "Press [ENTER] to continue..."
    fi
    printinfo "NFS filesystems mounted."
  fi

  printinfo "Verifying storage scheduler in grub"
  grep -qE "^GRUB_CMDLINE.*noop" /etc/default/grub
  rc=$?

  if [ ${rc} -eq 0 ]; then
    printinfo "noop elevator found!"
    printinfo "Backing up /etc/default/grub"
    cp -f /etc/default/grub /etc/default/grub.bak
    ls -l /etc/default | grep grub
    printinfo "Modifying /etc/default/grub"
    sed -i -e 's/\(^GRUB_CMDLINE.*\)noop/\1none/g' /etc/default/grub
    printinfo "Rebuilding grub.cfg"
    cp /boot/efi/EFI/redhat/grub.cfg /boot/efi/EFI/redhat/grub.cfg.bak
    grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
    printinfo "Grub configuration modified. Please verify output below"
    printmark
    grep "none" /boot/efi/EFI/redhat/grub.cfg
    printmark
    read -p "Press Enter to continue"
  else
    echo "noop elevator not found!"
  fi

  ans=0
  regkey=""
  while true; do
    printmark
    printinfo "Please select key for registering system to satellite"
    printinfo "== Generic content views. RHEL 8 latest available: "
    echo "    1 - ak-rhel8-generic-dev     # Generic content view for development,"
    echo "    2 - ak-rhel8-generic-cons    # Generic content view for consolidation"
    echo "    3 - ak-rhel8-generic-prod    # Generic content view for prod"
    printinfo "== SAP content views, RHEL 8.4"
    echo "    4 - ak-rhel84-e4s-dev        # E4S content view for development"
    echo "    5 - ak-rhel84-e4s-cons       # E4S content view for consolidation"
    echo "    6 - ak-rhel84-e4s-prod       # E4S content view for production"
    printmark
    read -p "Please select answer:" ans
    case ${ans} in
    1)
      regkey="ak-rhel8-generic-dev"
      echo "CV: generic" >> ${_statefile}
      echo "env: dev" >> ${_statefile}
      break
      ;;
    2)
      regkey="ak-rhel8-generic-cons"
      echo "CV: generic" >> ${_statefile}
      echo "env: cons" >> ${_statefile}
      break
      ;;
    3)
      regkey="ak-rhel8-generic-prod"
      echo "CV: generic" >> ${_statefile}
      echo "env: prod" >> ${_statefile}
      break
      ;;
    4)
      regkey="ak-rhel84-e4s-dev"
      echo "CV: E4S" >> ${_statefile}
      echo "env: dev" >> ${_statefile}
      break
      ;;
    5)
      regkey="ak-rhel84-e4s-cons"
      echo "CV: E4S" >> ${_statefile}
      echo "env: cons" >> ${_statefile}
      break
      ;;
    6)
      regkey="ak-rhel84-e4s-prod"
      echo "CV: E4S" >> ${_statefile}
      echo "env: prod" >> ${_statefile}
      break
      ;;
    *)
      echo "Wrong selection! Please select option from 1 to 6."
      ;;
    esac
  done

  printinfo "Verify selected options:"
  printmark 
  egrep "CV|env" ${_statefile}
  printmark
  read -p "Press enter to continue..."

  printinfo "Registering to target content view"
  subscription-manager unregister
  subscription-manager register --activationkey=${regkey} --org vwfs --force
  read -p "Press [Enter] to continue..."

  if grep -q "e4s" <<<${regkey}; then
    printinfo "E4S registration detected (${regkey})"
    ans=""
    while true; do
      read -p "Set release to 8.6? y/n (default: y): " ans
      ans=${ans:-y}
      case ${ans} in
      "y")
        printinfo "Setting release to 8.6."
        subscription-manager release --set=8.6
        break
        ;;
      "n")
        printinfo "Leaving default release version."
        break
        ;;
      *)
        echo "Wrong selection! Please answer y/n!"
        ;;
      esac
    done
  fi
  read -p "Press [ENTER] to continue..."

  printinfo "Cleaning dnf cache..."
  dnf clean all
  dnf repolist
  read -p "Press [Enter] to continue..."

  printinfo "Updating server to lates version"
  dnf update

  printinfo "Installing additional packages..."
  dnf install NetworkManager grub2-efi-x64-modules -y

  printinfo "Enabling puppet agent"

  puppet agent --enable
  echo "puppet: enabled" >> ${_statefile}

  printinfo "Running puppet agent -t"
  puppet agent -t
  read -p "Press [Enter] to continue..."

  printinfo "Enabling NetworkManager"
  systemctl enable NetworkManager

  printinfo "Disabling and removing network-scripts"
  systemctl disable network
  rpm -e network-scripts
  printmark
  systemctl is-enabled NetworkManager
  printmark
  read -p "Press [ENTER] to continue..."

  printmark
  printmark

  verify_state

  printinfo "== Upgrade finished, please perform following steps:"
  printwarn "In case of Connect:direct running, create link : ln -s /lib64/libtirpc.so.3 /lib64/libtirpc.so.1"
  printinfo "     - Reboot server to accomodate final update and reload initramfs"
  printinfo "     - Check icinga and correct any alerts and errors if necessary"
  printinfo "     - Correct \"Double motd\" and \"TMOUT\" errors"
  printinfo "     - Reconcile root password with CyberArk"
  printinfo "     - Remove icinga downtime:"
  echo "              /usr/isbs/bin/send_to_icinga --removedowntime --hostname $(hostname) >> /tmp/icinga_remove_downtime.txt"
  printinfo "     - Contact customer to perform application side checks"
  printinfo "     - Gather evidence for the change"
  printmark
  printmark
}

verify_state(){
  printinfo "performing final verification steps..."
  cv=$(grep "CV" ${_statefile})
  if [[ ${cv} == "E4S" ]]; then
    # if this is sap we verify if there is /daten or /data link:
    printinfo "Checking /daten link"
    printmark
    datenexists=$(grep "daten" ${_statefile} | awk -F ":" '{print $2}')
    if [[ ${datenexists} == "yes" ]]; then
      ls -l /daten
    else 
      echo " /daten doesn't found in state file"
    fi
    printmark
    printinfo "Verifying /data link"
    dataexists=$(grep "data" ${_statefile} | awk -F ":" '{print $2}') 
    if [[ ${dataexists} == "yes" ]]; then
      ls -l /data
    else
      echo "/data doesn't found in state file"
    fi
    printwarn "Verify output above. If necessary recreate links"
    read -p "press ENTER to continue..."
  else # not sap, check for MFT services
    printinfo "Verifying if MFT services were present"
    printmark
    mftexists=$(grep mft ${_statefile} | awk -F ":" '{print $2}')
    if [[ ${mftexists} == "yes" ]]; then
      ls -l /lib64/libtirpc.so.1
      rc=$?
      if [[ ${rc} -ne 0 ]]; then
        printwarn "recreating libtirpc link"
        ln -s /lib64/libtirpc.so.3 /lib64/libtirpc.so.1
      fi
    else
      printinfo "MFT Services not present in state file"
    fi
    printwarn "verify output above"
    read -p "Press ENTER to continue..."
  fi
  printinfo "Verifying NFS shares mounting"
  nfsexists=$(grep "nfs" ${_statefile} | awk -F ":" '{print $2}')
  printwarn "NFS filesystems found in statefile. Please verify if NFS shares were mounted correctly:"
  printmark
  echo "BEFORE:"
  printmark
  grep nfs /root/preupg-evidence/mount.out
  printmark
  echo AFTER:
  printmark
  mount | grep nfs
  printmark
  printwarn "Please verify output above"
  read -p "Press ENTER to continue..."

}

fsconvert() {

  #############################################################################################
  #
  # Function for converting OS filesystems from ext3/4 to xfs
  # Filesystems are unmounted if possible, and conversion is done in-place if possible
  # Filesystems that can not be unmounted are backed up and recreated as xfs
  #
  ##############################################################################################

  printinfo "Verifying fstransform and gdisk installation..."
  rpm --quiet -q gdisk
  rc=$?
  if [ $rc -ne 0 ]; then
    printcrit "gdisk not installed!"
    printcrit "Install gdisk before running fsconvert!"
    exit 1
  fi
  rpm --quiet -q fstransform
  rc=$?
  if [ $rc -ne 0 ]; then
    printcrit "fstransform not installed!"
    printcrit "Install fstransform before running fsconvert"
    exit 1
  fi
  rpm --quiet -q rsync
  rc=$?
  if [ $rc -ne 0 ]; then
    printcrit "rsync not installed!"
    printcrit "Install rsync before running fsconvert"
    exit 1
  fi

  vgsize=$(vgs --noheadings system${_hostnum} -o vg_size)
  printwarn "Please attach new temporary disk with ${vgsize} size at least"
  read -p "Enter a name for the temporary disk (e.g. sdb) and press [Enter]: " tmpdiskans
  if [[ -z ${tmpdiskans} ]]; then
    printwarn "No disk provided!"
    read -p "Enter a name for the temporary disk (e.g. sdb) and pres [Enter]: " tmpdiskans
    if [[ -z ${tmpdiskans} ]]; then
      printcrit "No temporary disk provided! Exitting..."
      exit 1
    fi
  fi

  tmpdisk=$(echo ${tmpdiskans} | sed 's/\(.*\)\(sd[a-z]\)/\2/g')
  printok "Using: /dev/${tmpdisk}..."
  printinfo "Creating new PV for system${_hostnum}"
  #gdisk -l /dev/${tmpdisk}
  parted -s /dev/${tmpdisk} print
  printmark
  echo
  printmark
  pvscan
  pvs | grep ${tmpdisk}
  printmark
  printwarn "Please verify temporary disk is empty before proceeding!!!"
  read -p "Press ENTER to continue..."

  #printf "n\n\n\n\n8E00\nw\nY\n" | gdisk /dev/${tmpdisk}
  pvcreate /dev/${tmpdisk}
  vgextend system${_hostnum} /dev/${tmpdisk}
  printmark
  #gdisk -l /dev/${tmpdisk}
  printmark
  pvs -S vg_name=system${_hostnum}
  printmark
  read -p "Press [Enter] to continue..."

  srcpv=/dev/${_pvpart}
  destpv=/dev/${tmpdisk}

  printinfo "Stopping puppet and besclient services..."
  systemctl stop puppet
  systemctl stop besclient
  printinfo "Stopping dsmcad services"
  for service in $(systemctl -t service | grep dsm | awk '{print $1}'); do
    systemctl stop ${service}
  done
  printinfo "Checking for prole_*.service"
  systemctl -t service | grep "prole_"
  rc=$?
  if [[ ${rc} -eq 0 ]]; then
    for prole_svc in $(systemctl -t service | grep "prole_" | awk '{print $1}'); do
      printinfo "Stopping ${prole_svc}..."
      systemctl stop ${prole_svc}
    done
  else
    printinfo "no prole_*.service found"
  fi

  #systemctl stop auditd
  auditctl -e0

  printmark
  printinfo "Evidence mount BEFORE"
  cat /proc/mounts | grep system${_hostnum} | egrep ext[34]
  printinfo "Evidence fstab BEFORE"
  cat /etc/fstab | grep system${_hostnum} | egrep ext[34]
  printmark

  printinfo "Converting ext filesystems to xfs"
  printinfo "Moving LVs to temporary disk..."


  # verifying ig source pv is not empty. If it is we don't move the pv
  pvsize=$(pvs -o name,pv_size,pv_free --unit m /dev/sda3 --noheading | awk '{ print $2}' | sed 's/m//g')
  pvfree=$(pvs -o name,pv_size,pv_free --unit m /dev/sda3 --noheading | awk '{ print $3}' | sed 's/m//g')

  # both values are float so we need to compare as text

  if [[ ${pvsize} != ${pvfree} ]]; then
    pvmove -A y --atomic ${srcpv} ${destpv}
    rc=$?
    if [ ${rc} -ne 0 ]; then
      printcrit "ERROR while moving ${srcpv} to ${destpv}"
      exit 1
    fi
  else
    printinfo "${srcpv} seems empty... Please verify before proceeding"
    printmark
    pvs ${srcpv}
    printmark
    read -p "Press ENTER to continue..."
  fi

  #for logvol in $(lvs --noheadings ${_sysvg} -o name,devices | grep ${srcpv} | grep -v "_old" | awk '{print $1}'); do
  #  printinfo "Moving ${logvol} from ${srcpv} to ${dstpv}..."
  #  log "INFO" "Moving ${logvol}; ${srcpv} -> ${dstpv}"
  #  pvmove -Ay --atomic ${srcpv} ${tmp_pv}
  #  rc=$?

  #  if [ ${rc} -ne 0 ]; then
  #    printcrit "${logvol} moving error! Aborting!"
  #    printmark
  #    printwarn "ERROR: Not moved ${logvol}!"
  #    printwarn "DEBUG: SRC: ${srcpv}"
  #    printwarn "DEBUG: DST: ${dstpv}"
  #    printmark
  #    exit 1
  #  else
  #    printok "${logvol} moved correctly."
  #  fi
  #done

  printinfo "LV's moved correctly to temp disk. Please verify"
  printmark
  lvs -o name,devices ${_sysvg}
  printmark

  # Recreating filesystems with xfs

  srcpv=/dev/${tmpdisk}
  dstpv=/dev/${_pvpart}
  for logvol in $(lvs --noheadings ${_sysvg} -o name,devices | grep -v ${dstpv} | grep -v "old" | awk '{print $1}'); do
    fstype=$(grep "\-${logvol}" /proc/mounts | awk '{ print $3 }')

    if [ -z ${fstype} ]; then
      printcrit "Can't verify filetype of ${logvol}! Aborting"
      printwarn "ERROR" "${logvol} filetype not found in /proc/mounts!"
      printwarn "DEBUG" "logvol: ${logvol}"
      exit 1
    fi

    mntpoint=$(grep "\-${logvol}" /proc/mounts | awk '{print $2}')

    if [ -z ${mntpoint} ]; then
      printcrit "Can't verify ${logvol} mountpoint!"
      printcrit "${logvol} not mounted?"
      printmark
      printcrit "ERROR: ${logvol} mountpoint not found in /proc/mounts"
      printinfo "DEBUG logvol: ${logvol}"
      printmark
      exit 1
    fi

    lvpath=/dev/${_sysvg}/${logvol}
    lvsize=$(lvdisplay --noheadings -C -o lv_size --unit m ${lvpath})

    printinfo "Processing ${mntpoint}"

    # if the fs is already in xfs then we just move it back
    if [ ${fstype} == "xfs" ]; then
      printok "Filesystem ${mntpoint} on /dev/${_sysvg}/${logvol} already in xfs"
      printok "Moving back to ${dstpv}"
      pvmove -Ay --atomic -n ${logvol} ${srcpv} ${dstpv}
      rc=$?
      if [ $rc -ne 0 ]; then
        printcrit "Error while moving ${logvol} to ${dstpv}! Aborting!"
        printmark
        printwarn "DEBUG lv: ${logvol}"
        printwarn "DEBUG pvmove error code: ${rc}"
        printwarn "DEBUG Filesystem: ${fstype}"
        printwarn "DEBUG Mountpoint: ${mntpoint}"
        printmark
        exit 1
      fi
    elif [ ${fstype} == "ext4" ]; then
      # Rename, recreate, make temporary dir rsync data
      printinfo "Renaming ${lvpath} to ${lvpath}_old"
      lvrename ${lvpath} ${lvpath}_old
      rc=$?
      if [ ${rc} -ne 0 ]; then
        printcrit "Can't rename ${logvol}"
        printmark
        printwarn "DEBUG logvol: ${logvol}"
        printwarn "DEBUG lvpath: ${lvpath}"
        printwarn "DEBUG filesystem: ${fstype}"
        printwarn "DEBUG mountpoint: ${mntpoint}"
        printwarn "DEBUG lvrename exit code: ${rc}"
        exit 1
      else
        printok "${logvol} renamed successfully"
      fi

      printinfo "Recreating logical volume on ${dstpv}"

      lvcreate -n ${logvol} -L ${lvsize} ${_sysvg} ${dstpv}
      rc=$?

      if [ ${rc} -ne 0 ]; then
        printcrit "Can't recreate ${lvpath}"
        printmark
        printwarn "ERROR lvsize: ${lvsize}"
        printwarn "ERROR sysvg: ${_sysvg}"
        printwarn "ERROR destpv: ${dstpv}"
        printwarn "DEBUG logvol: ${logvol}"
        printwarn "DEBUG lvpath: ${lvpath}"
        printwarn "DEBUG filesystem: ${fstype}"
        printwarn "DEBUG mountpoint: ${mntpoint}"
        printwarn "DEBUG lvcreate exit code: ${rc}"
        printmark
        exit 1
      else
        printok "${lvpath} created successfully"
      fi

      printinfo "Creating XFS filesyste on ${lvpath}"

      mkfs.xfs ${lvpath}
      rc=$?

      if [ ${rc} -ne 0 ]; then
        printcrit "Can't create xfs on ${lvpath}"
        printmark
        printwarn "DEBUG logvol: ${logvol}"
        printwarn "DEBUG lvpath: ${lvpath}"
        printwarn "DEBUG filesystem: ${fstype}"
        printwarn "DEBUG mountpoint: ${mntpoint}"
        printwarn "DEBUGmkfs exit code: ${rc}"
        printmark
        exit 1
      else
        printok "XFS on ${lvpath} created successfully"
      fi

      printinfo "Creating mountpoint /mnt/${logvol}"
      mkdir /mnt/${logvol}

      printinfo "Mounting ${lvpath} to /mnt/${logvol}"
      mount ${lvpath} /mnt/${logvol}
      rc=$?

      if [ ${rc} -ne 0 ]; then
        printcrit "Can't mount ${lvpath} on /mnt/${logvol}"
        printmark
        printwarn "DEBUG logvol: ${logvol}"
        printwarn "DEBUG lvpath: ${lvpath}"
        printwarn "DEBUG filesystem: ${fstype}"
        printwarn "DEBUG mountpoint: ${mntpoint}"
        printwarn "DEBUG mount exit code: ${rc}"
        printmark
        exit 1
      else
        printok "${lvpath} mounted successfully."
      fi

      printinfo "rsyncing ${mntpoint} to /mnt/${logvol}"
      rsync -axu ${mntpoint}/ /mnt/${logvol}
      rc=$?

      if [ ${rc} -ne 0 ]; then
        printcrit "Can't rsync ${mntpoint} to /mnt/${logvol}"
        printmark
        printwarn "DEBUG logvol: ${logvol}"
        printwarn "DEBUG lvpath: ${lvpath}"
        printwarn "DEBUG filesystem: ${fstype}"
        printwarn "DEBUG mountpoint: ${mntpoint}"
        printwarn "DEBUG mount exit code: ${rc}"
        printmark
        exit 1
      else
        printok "${mntpoint} rsynced to /mnt/${logvol} successfully."
      fi

      printinfo "Unmounting /mnt/${logvol}"
      umount /mnt/${logvol}
      rc=$?

      if [ ${rc} -ne 0 ]; then
        printcrit "Can't unmount /mnt/${logvol}"
        printmark
        printwarn "DEBUG logvol: ${logvol}"
        printwarn "DEBUG lvpath: ${lvpath}"
        printwarn "DEBUG filesystem: ${fstype}"
        printwarn "DEBUG mountpoint: ${mntpoint}"
        printwarn "DEBUG mount exit code: ${rc}"
        printmark
        exit 1
      else
        printok "/mnt/${logvol} unmounted successfully."
      fi
      printok "${mntpoint} processed successfully"
    else
      printcrit "Filesystem not ext4 or xfs!"
      printmark
      printwarn "DEBUG logvol: ${logvol}"
      printwarn "DEBUG lvpathL ${lvpath}"
      printwarn "DEBUG filesystem: ${fstype}"
      printwarn "DEBUG mountpoint: ${mntpoint}"
    fi
    printinfo "Modifying fstab entry"
    sed -i -e "s#${mntpoint}\s*ext[34]#${mntpoint}\txfs#" /etc/fstab
    read -p "Press ENTER to continue..."
  done

  read -p "Press ENTER to continue..."

  printmark
  printinfo "Evidence mount AFTER"
  cat /proc/mounts | grep system${_hostnum} | egrep ext[34]
  printinfo "Evidence fstab AFTER"
  cat /etc/fstab | grep system${_hostnum}
  printinfo "Please verify above output before proceeding."
  read -p "Press ENTER to continue..."

  printinfo "remounting root_lv to /mnt/root_lv"
  mount /dev/${_sysvg}/root_lv /mnt/root_lv
  rc=$?

  if [ ${rc} -ne 0 ]; then
    printcrit "Can't mount ${lvpath} on /mnt/${logvol}"
    printmark
    printwarn "DEBUG logvol: ${logvol}"
    printwarn "DEBUG lvpath: ${lvpath}"
    printwarn "DEBUG filesystem: ${fstype}"
    printwarn "DEBUG mountpoint: ${mntpoint}"
    printwarn "DEBUG mount exit code: ${rc}"
    printmark
    exit 1
  else
    printok "${lvpath} mounted successfully."
  fi
  
  printinfo "Copying modified fstab to new lv"
  cp -f /etc/fstab /mnt/root_lv/etc/fstab
  printmark
  cat /mnt/root_lv/etc/fstab
  printmark
  read -p "Press [ENTER] to continue..."

  printinfo "Rebuilding initramfs to include xfs drivers..."
  cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
  cp /boot/initramfs-$(uname -r)kdump.img /boot/initramfs-$(uname -r)kdump.img.bak

  printinfo "Initramfs backed up. Regenerating..."
  dracut -f -v --add-drivers xfs

  printinfo "Initramfs rebuilt."
  read -p "Press ENTER to continue"

  printinfo "Ensuring module loading for next reboot..."
  echo "xfs" >/etc/modules-load.d/xfs.conf

  printmark
  lsinitrd | grep xfs
  printinfo "Verify output above if initramfs has xfs modules"
  read -p "Press ENTER to continue..."

  printmark
  printcrit "Please reboot system and verify filesystems"
}

tmpcleanup() {

  ###################################################################################################
  #
  # Function for cleaning of attached temporary disk for furhter use in partition table conversion
  #
  ####################################################################################################

  printinfo "Cleaning temporary disk..."
  read -p "Enter a name of the temporary disk to clean: " _tmpdiskans
  if [[ -z ${_tmpdiskans} ]]; then
    printcrit "Temporary disk not provided!"
    exit 1
  fi

  _tmpdisk=$(echo ${_tmpdiskans} | sed 's/\(.*\)\(sd[a-z]\)/\2/g')
  printok "Using /dev/${_tmpdisk}..."

  printmark
  lvs -o +devices | grep ${_tmpdisk}
  printmark
  printwarn "Verify output above before proceeding!"
  read -p "Press [ENTER] to continue..."

  printinfo "Removing old lvs from tmp disk"
  for lvname in $(lvs --noheadings | grep "_old" | awk '{print $1}'); do
    printinfo "Processing ${lvname}..."
    lvchange -an /dev/system${_hostnum}/${lvname}
    rc=$?
    if [[ ${rc} -ne 0 ]]; then
      printcrit "Can't deactivate logical volume ${lvname}! Please check!"
      exit 12
    fi
    lvremove /dev/system${_hostnum}/${lvname}
    rc=$?
    if [[ rc -ne 0 ]]; then
      printcit "Can't remove logical volume ${lvname}! Please check"
      exit 12
    fi
  done
  printinfo "Logical volumes removed."
  printmark
  lvs
  printmark
  printinfo "Please verify output above if _old LVs were removed"
  read -p "Press [ENTER] to continue..."

  printinfo "Temporary disk cleaned up."
  printmark
  lvs
  printmark
  pvs
  printmark
  read -p "Press [ENTER] to continue..."
}

usage() {
  echo "Usage: $0 <options>"
  echo "  Options:"
  echo "          rpmreport   - Generate non-Red Hat provided packages report"
  echo "          prepare     - Gather evidence, set icinga downtime"
  echo "          fsconvert   - Convert ext4 filesystems to xfs"
  echo "          tmpcleanup  - cleanup temporary disk for reusing"
  echo "          ptconvert   - Convert partition table from MBR to GPT"
  echo "          upgrade     - Perform VM upgrade"
  echo "          post        - Perform post upgrade tasks"
}

case "$1" in
prepare)
  prepare78
  ;;
upgrade)
  upgrade78
  ;;
post)
  post
  ;;
fsconvert)
  fsconvert
  ;;
ptconvert)
  ptconvert
  ;;
tmpcleanup)
  tmpcleanup
  ;;
rpmreport)
  rpmreport
  ;;
*)
  usage
  exit 1
  ;;
esac

exit 0
