#!/bin/bash

# TODO:
# - sapinit.service
# - cluster build
# DONE udev oracle
# DONE hardening (auto)
# DONE pam_stack (auto)
# DONE extended /boot warning
# DONE tsmsched stop/disable (1316, 1327, 1324, 1325) and (1313, 1315)
# DONE replace dsmcad by .service (1313, 1315, 1318, 1200, 1326)
# DONE [root@bsul1729 ~]# ls -l /etc/systemd/system/dsmcad.service
# DONE prole_ora
# SKIP icinga all services

_reqver="6.10"
_targetver="76"
_instneed=5
_regkey="1-a640d4428b1cbaa06a29d4f468ffec96"
_channel_base="i-sbs-rhel69_64-062018"
_channel_base_name="I-SBS RHEL (v. 6 for 64-bit x86_64) Update 10 Jun 2018"
_channel_extra="i-sbs-rhel-extra-x86_64-062018"
_channel_opt="i-sbs-rhel-x86_64-server-optional-6-062018"

_curver=$(lsb_release -s -r)
_curmajver=${_curver:0:1}
_host=$(hostname -s)
_hostnum=${_host:4:4}
_pridisk=$(df -P /boot | grep 'boot$' | cut -c 6-8)
_disksize=$(lsblk --nodeps --noheadings --output SIZE /dev/${_pridisk} | sed 's/G//')

if [ ${_curmajver} -eq 6 ]; then

	_usrexist=$(df -Pk | grep -c "/usr$")
	_vhost=$(cat /dev/$(lsblk | grep '256K' | awk '{print $1}') | strings | grep bsul | sed 's/^.*bsul//')

	rootok=0
	bootok=0
	varok=0
	vgok=0
	rootneed=0
	
	vardev=$(df -Pk | grep "/var$" | awk '{print $1}')
	varfree=$( df -Pk | grep "/var$" | awk '{print $4}')
	[ ${varfree} -lt 4194304 ] && varneed=$((((4194304-${varfree})/1048576)+1)) || varok=1
	rootdev=$(df -Pk | grep "/$" | awk '{print $1}')
	rootfree=$( df -Pk | grep "/$" | awk '{print $4}')
	if [ ${_usrexist} -eq 1 ]; then
		usrused=$( df -Pk | grep "/usr$" | awk '{print $3}')
		[ ${rootfree} -lt ${usrused} ] && rootneed=$((((${usrused}-${rootfree})/1048576)+3)) || rootok=1
		usrdev=$(df -Pk | grep "/usr$" | awk '{print $1}')
	else
		rootok=1
	fi
	bootdev=$(df -Pk | grep "/boot$" | awk '{print $1}')
	bootfree=$(df -Pk | grep "/boot$" | awk '{print $4}')
	[ ${bootfree} -gt 204800 ] && bootok=1
	partid=$(sfdisk -c /dev/${_pridisk} 1)
	if [ "${bootdev}" != "/dev/${_pridisk}1" ]; then
		bootok=2
	fi
	if [ ${partid} -ne 83 ]; then
		bootok=2
	fi
	partid=$(sfdisk -c /dev/${_pridisk} 2)
	if [ ${partid} -ne 82 ]; then
		bootok=2
	fi
	vgrequired=$((${varneed}+${rootneed}+${_instneed}))
	vgfree=$(vgs --rows --units g system${_hostnum} | grep VFree | awk '{print $2}' | cut -d '.' -f 1)
	[ ${vgfree} -gt ${vgrequired} ] && vgok=1
	
	sat_chan_extra=$(yum repolist 2>&1 | grep -c ${_channel_extra})
	sat_chan_opt=$(yum repolist 2>&1 | grep -c ${_channel_opt})

fi

printok() {
	echo "[01;32m$1[0m"
	}
printwarn() {
	echo "[01;33m$1[0m"
	}
printcrit() {
	echo "[01;31m$1[0m"
}

precheck() {

	if [ ${_curmajver} -eq 7 ]; then
		echo "Option available only on RHEL 6.X"
		exit 1
	fi
	
	printwarn "Request new LUN $((${_disksize}+10))G size."
	
	if [ ${_curver} == ${_reqver} ]; then
		printok "OS version and Base channel are correct."
	else
		printwarn "Assign system to ${_channel_base_name} channel in Red Hat Satellite (${_channel_base}) and update OS (yum update)"
	fi
	
	if [ ${sat_chan_extra} -eq 0 ]; then
		printwarn "Assign system to ${_channel_extra} channel"
	else
		printok "Extra channel available."
	fi
	
	if [ ${sat_chan_opt} -eq 0 ]; then
		printwarn "Assign system to ${_channel_opt} channel"
	else
		printok "Optional channel available."
	fi
	
	if [ ${rootok} -eq 1 ]; then
		printok "Size of root filesystem is sufficient."
	else
		printwarn  "Root filesystem needs to be extended (+${rootneed}G). No action required."
	fi

	if [ ${varok} -eq 1 ]; then
		printok	 "Size of /var filesystem is sufficient."
	else
		printwarn "/var filesystem needs to be extended (+${varneed}G). No action required."
	fi
	
	if [ ${bootok} -eq 1 ]; then
		printok "Size of /boot filesystem is sufficient."
	elif [ ${bootok} -eq 2 ]; then
		printcrit "/boot filesystem needs to be extended according to the 6.2.4.7.1.1 SOP-X-2040 Linux major upgrade"
	elif [ ${bootok} -eq 0 ]; then
		printwarn "/boot filesystem needs to be extended. No action required."
	fi

	if [ ${vgok} -eq 1 ]; then
		printok "Size of root VG is sufficient."
	else
		printcrit "Root VG needs to be extended"
		exit 1
	fi

	printcrit "Please execute $0 backup when you are ready to start process."
}

backup() {

	
	echo "=== Setup maintenance mode..."
	echo "Log-in on bsul0598 and execute:"
	echo "  /usr/lib64/nagios/plugins/send_to_icinga --setdowntime --date now --duration 4 --author IH-IOIX-MSP --host bsul${_hostnum} --comment Upgrade6to7"
	read -p "Press [Enter] to continue..."
	
	echo
	read -p "Enter your new LUN name (gvXXXX_XXXX): " lunname
	echo
	echo "=== Next steps:"
	echo " - shutdown system (automatic)"
	echo " - log-in to vHost ${_vhost}, wait until VM will be shut off and execute:"
	echo "      virsh list --all | grep bsul${_hostnum}"
	echo "      scan_fc.pl"
	echo "      pvcreate /dev/mapper/${lunname}"
	echo "      vgextend bl${_hostnum}vg01 /dev/mapper/${lunname}"
	echo "      lvrename /dev/bl${_hostnum}vg01/bl${_hostnum}lv01 bl${_hostnum}lv01_old"
	echo "      lvcreate -n bl${_hostnum}lv01 -L $((${_disksize}+8))G bl${_hostnum}vg01"
	echo "      cat /dev/bl${_hostnum}vg01/bl${_hostnum}lv01_old > /dev/bl${_hostnum}vg01/bl${_hostnum}lv01"
	echo "      virsh start bsul${_hostnum}"
	echo " - log-in to paired vHost and execute:"
	echo "      scan_fc.pl"
	echo "      pvscan"
	echo "      vgchange -an bl${_hostnum}vg01"
	echo "      vgchange -ay bl${_hostnum}vg01"
	read -p "Press [Enter] to power off..."
	poweroff

}

prepare() {
	
	if [ ${_curmajver} -eq 7 ]; then
		echo "Option available only on RHEL 6.X"
		exit 1
	fi

	echo "=== Preparing evidence (/root/preupg-evidence) ..."
	mkdir /root/preupg-evidence
	fdisk -cul > /root/preupg-evidence/fdisk.out
	lvs > /root/preupg-evidence/lvs.out
	lvscan > /root/preupg-evidence/lvscan.out
	ip addr show > /root/preupg-evidence/ip_addr.out
	ip route show > /root/preupg-evidence/ip_route.out
	cat /proc/mounts > /root/preupg-evidence/mount.out
	cat /proc/cmdline > /root/preupg-evidence/cmdline.out
	rpm -qa > /root/preupg-evidence/rpm.out
	
	echo "=== Cleaning yum cache..."
	rm -Rf /var/cache/yum/*

	echo "=== Removing unused kernels..."
	curkern=$(uname -r)
	for a in $(rpm -q kernel) ; do
		if [ ! ${a} == "kernel-${curkern}" ]; then
			echo "Removing ${a}..."
			rpm -e "${a}"
		fi
	done
	read -p "Press [Enter] to coninue..."

	if [ ${vgok} -ne 1 ]; then
		echo "=== Extending Root VG..."
		sfdisk -q -uS -l /dev/${_pridisk} > /tmp/sfdisk2.out
		rc=$(grep -c "${_pridisk}4.*Empty" /tmp/sfdisk2.out)
		if [ $rc -eq 0 ]; then
			echo "Please extend manually system${_hostnum} VG"
			exit 1
		fi
		printf "n\np\n\n\nt\n4\n8e\n\nw\n" | fdisk -cu /dev/${_pridisk}
		partx -a /dev/${_pridisk}
		fdisk -cul /dev/${_pridisk}
		pvcreate /dev/${_pridisk}4
		vgextend system${_hostnum} /dev/${_pridisk}4
		pvscan
		vgdisplay system${_hostnum}
		read -p "Press [Enter] to coninue..."
	fi

	if [ ${varok} -ne 1 ]; then
		echo "=== Resizing /var filesystem..."
		lvextend -L +${varneed}G ${vardev}
		resize2fs ${vardev}
		read -p "Press [Enter] to coninue..."
	fi
	
	if [ ${rootok} -ne 1 ]; then
		echo "=== Resizing / filesystem..."
		lvextend -L +${rootneed}G ${rootdev}
		resize2fs ${rootdev}
		read -p "Press [Enter] to coninue..."
	fi
	
	if [ ${bootok} -eq 0 ]; then
		echo "=== Resizing /boot filesystem..."
		sfdisk -q -uS -l /dev/${_pridisk} > /tmp/sfdisk.out
		swapend=$(grep "${_pridisk}2" /tmp/sfdisk.out | awk '{print $3}')
		swapuuid=$(blkid /dev/${_pridisk}2 | sed 's/"//g' | awk '{print $3}')
		umount /boot
		swapoff -a
		printf "d\n1\nd\n2\nw\n" | fdisk -cu /dev/${_pridisk}
		partx -d /dev/${_pridisk}
		printf "n\np\n1\n2048\n616447\nn\np\n2\n616448\n${swapend}\nt\n2\n82\nw\n" | fdisk -cu /dev/${_pridisk}
		partx -a /dev/${_pridisk}
		e2fsck -f /dev/${_pridisk}1
		resize2fs /dev/${_pridisk}1
		e2fsck -f /dev/${_pridisk}1
		mkswap -U ${swapuuid#*=} /dev/${_pridisk}2
		mount /boot
		swapon -a
		echo "-----------"
		fdisk -cul /dev/${_pridisk}
		df -hP /boot
		read -p "Press [Enter] to coninue..."
	fi

	if [ ! -b /dev/system${_hostnum}/install ]; then
		echo "=== Creating temporary installation LV..."
		lvcreate -L ${_instneed}G -n install system${_hostnum}
		mkfs.ext4 /dev/system${_hostnum}/install
		read -p "Press [Enter] to coninue..."
	fi
	
	if [ $(cat /proc/mounts | grep -c "/dev/system${_hostnum}/install") -eq 0 ];then
		echo "=== Mounting installation LV..."
		mount /dev/system${_hostnum}/install /mnt
	fi

	if [ ! -f /mnt/.discinfo ]; then
		echo "=== Copy ISO content to /mnt directory..."
		echo "Run on bsux0020:"
	        echo "	rsync -avxu /export/RHEL${_targetver}_64/ bsul${_hostnum}a01:/mnt/"
		read -p "Press [Enter] to coninue..."
	fi

	echo "=== Removing unwanted packages..."
	yum -y remove compat-libstdc++-33 liboil libproxy-bin libproxy-python libreport-compat \
		libreport-plugin-kerneloops pcsc-lite-devel perl-Config-Tiny vm-dump-metrics vwfs-orasys
	read -p "Press [Enter] to coninue..."
	
	echo "=== Updating system..."
	yum -y update
	read -p "Press [Enter] to coninue..."
	
	echo "=== Disabling and stopping rsyslog..."
	chkconfig rsyslog off
	service rsyslog stop
	read -p "Press [Enter] to coninue..."
	
	if [ -f /etc/cluster/cluster.conf ]; then
		printwarn "=== Cluster detected. Generating pacemaker configuration..."
		cat /etc/cluster/cluster.conf > /root/preupg-evidence/cluster.conf
		_clustername=$(cman_tool status | grep "^Cluster Name:"| cut -d ' ' -f3)
		_rgname=$(grep '<service' /root/preupg-evidence/cluster.conf | tr " " "\n" | grep "^name=" | sed 's/\"//g' | sed 's/^.*=//')
		_node1=$(corosync-quorumtool -l | grep bsul | awk '{print $2}' | head -n 1)
		_node2=$(corosync-quorumtool -l | grep bsul | awk '{print $2}' | tail -n 1)
		cat > /root/pcs.info << EOF
1. Assign ih-ioix-rhel-x86_64-server7-ha-122018 channel to both systems
2. Detach and remove blXXXXlvqd disks from both systems
      virsh domblklist bsulXXXX
      virsh detach-disk bsulXXXX YYY --config --live
3. Extend blXXXXvgfq to 1GB and refresh disks on both systems
      lvextend -L 1G .....
      virsh blockresize bsulXXXX YYY
4. Configure sbd device (blXXXXvgfq) serial sdx (using kvi) and add to udev rules (/etc/udev/rules.d/61-cluster.rules):
      KERNEL=="sd*", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", ENV{ID_SCSI_SERIAL}=="sdx", SYMLINK+="fence",  GROUP="disk", OWNER="root", MODE="0640", OPTIONS="last_rule" 
5. Add watchdog device to both systems (use kvi):
     <watchdog model='i6300esb' action='reset'>
         <alias name='watchdog0'/>
     </watchdog>
6. Install cluster software (from bsux0020):
     /export/software/pacemaker/bin/install_pacemaker.sh -p ${_node1},${_node2} 
7. Preconfigure pacemaker (on this node):
     /root/configure_pacemaker.sh -n ${_clustername} -p ${_node1},${_node2} -g ${_rgname} -r
8. Add resources:
EOF
		grep -q check_gw /root/preupg-evidence/cluster.conf
		rc=$?
		if [ $rc -eq 0 ]; then
		        echo "pcs resource create check_gw lsb:check_gw --group ${_rgname} op monitor interval=60 timeout=100" >> /root/pcs.info
		fi
		_ipcount=1
		for a in $( grep '<ip' /root/preupg-evidence/cluster.conf | tr " " "\n" | grep address | sed 's/\"//g' | sed 's/^.*=//') ; do
			_ipdev=$(/sbin/ip addr show | grep ${a} | awk '{print $NF}')
			_ipmask=$(/sbin/ip addr show | grep ${a} | awk '{print $2}' | sed 's/^.*\///')
			echo "pcs resource create vip${_ipcount}_${_ipdev} IPaddr2 ip=${a} cidr_netmask=${_ipmask} nic=${_ipdev} --group ${_rgname}" >> /root/pcs.info
			_ipcount=$((${_ipcount}+1))
		done
		echo "pcs resource create systemd_vwfs-sshd-reload systemd:vwfs-sshd-reload --group ${_rgname}" >> /root/pcs.info
		grep '<lvm' /root/preupg-evidence/cluster.conf | sed 's/^.* name=//' | sed 's/>//' | \
			sed 's/\"//g' | sed 's/vg_name/LVM exclusive=true volgrpname/' | \
			sed 's/^/pcs resource create /' | sed "s/$/ --group ${_rgname}/" >> /root/pcs.info
		for a in $(grep '<fs ' /root/preupg-evidence/cluster.conf | sed 's/mountpoint/directory/g' | sed 's/\"//g' | tr " " ";"); do
			_fsname=$(echo $a | tr ";" "\n" | egrep "^name" | sed 's/^.*=//')
			_fsparam=$(echo $a | tr ";" "\n" | egrep "(^device|^fstype|^directory)" | tr "\n" " ")
			echo "pcs resource create ${_fsname}_fs Filesystem ${_fsparam}" >> /root/pcs.info
		done
		echo >> /root/pcs.info
		echo "9. Please consider the following scripts resources:" >> /root/pcs.info
		grep '<script' /root/preupg-evidence/cluster.conf  | sed 's/^.*</</g' >> /root/pcs.info

		echo >> /root/pcs.info
		echo "10. To use SAP resources:" >> /root/pcs.info
		echo "  - install resource-agents-sap package" >> /root/pcs.info
		echo " examples:" >> /root/pcs.info
		echo "  - pcs resource create SAPDatabase_F3P SAPDatabase AUTOMATIC_RECOVER=TRUE DBTYPE=ORA SID=F3P STRICT_MONITORING=TRUE" >> /root/pcs.info
		echo "  - pcs resource create AMP_ASCS50_ascsamp SAPInstance AUTOMATIC_RECOVER=FALSE DIR_EXECUTABLE=/usr/sap/AMP/SYS/exe/run DIR_PROFILE=/usr/sap/AMP/SYS/profile InstanceName=AMP_ASCS50_ascsamp START_PROFILE=/usr/sap/AMP/SYS/profile/AMP_ASCS50_ascsamp" >> /root/pcs.info
		echo "  - pcs resource create AMP_DVEBMGS00_a01amp SAPInstance AUTOMATIC_RECOVER=TRUE DIR_EXECUTABLE=/usr/sap/AMP/SYS/exe/run DIR_PROFILE=/usr/sap/AMP/SYS/profile InstanceName=AMP_DVEBMGS00_a01amp START_PROFILE=/usr/sap/AMP/SYS/profile/AMP_DVEBMGS00_a01amp START_WAITTIME=120" >> /root/pcs.info

	fi

	echo "=== Installing required packages..."
	yum -y install redhat-upgrade-tool preupgrade-assistant preupgrade-assistant-el6toel7
	read -p "Press [Enter] to coninue..."
	
	echo "=== Configuring GRUB for the next start..."
	grubmodified=$(grep -c 'init=/bin/sh' /boot/grub/grub.conf)
	if [ ${grubmodified} -eq 0 ]; then
		sed -i '/kernel/ s/$/ init=\/bin\/sh/' /boot/grub/grub.conf
	fi

	echo "=== Updating /etc/fstab..."
	/bin/mv -f /etc/fstab /etc/fstab.orig
	egrep "(boot|system${_hostnum})" /etc/fstab.orig > /etc/fstab
	read -p "Press [Enter] to continue..."
	
	answer="n"
        read -p "=== Please type 'yes' to start incremental backup (required for production environment): " answer
	if [ "${answer}" == "yes" ]; then
		echo "=== Starting incremental backup..."
		dsmc i
		read -p "Press [Enter] to continue..."
	fi

cat > /fix.sh <<EOF
#/bin/sh
echo "=== Remounting /"
mount -o remount,rw /
echo "=== Starting udev"
start_udev
sleep 5
udevadm trigger
sleep 3
echo "=== Activating LV"
vgchange -ay
echo "=== Mounting /mnt"
mount ${usrdev} /mnt
[ $? -ne 0 ] && exit 1
echo "=== Copying /usr"
mv /mnt/* /usr
[ $? -ne 0 ] && exit 1
echo "=== Unmounting /mnt"
umount /mnt
[ $? -ne 0 ] && exit 1
echo "=== Removing usr LV"
lvremove -y ${usrdev}
echo "=== Removing /usr from /etc/fstab"
sed -i "/system${_hostnum}-usr_lv/d" /etc/fstab
sed -i "/system${_hostnum}-usr_lv/d" /etc/fstab.orig
echo "=== Mounting /boot"
mount /boot
echo "=== Removing init=/bin/sh from grub.conf"
sed -i 's/ init=\/bin\/sh//g' /boot/grub/grub.conf
EOF
	if [ ${bootok} -eq 2 ]; then
cat >> /fix.sh <<EOF
echo "=== /boot partition must be manually extended !!!"
echo "=== Perform this according to the SOP and then run script /fix2.sh"
exit 0
EOF
cat > /fix2.sh <<EOF
#/bin/sh
sync
echo "=== Removing /fix* scripts"
rm -f /fix.sh /fix2.sh
echo "=== Remounting /"
mount -o remount,ro /
echo "=== Rebooting"
/sbin/reboot -nfi
EOF
chmod 755 /fix.sh /fix2.sh
	else
cat >> /fix.sh <<EOF
sync
echo "=== Removing /fix* scripts"
rm -f /fix.sh
echo "=== Remounting /"
mount -o remount,ro /
echo "=== Rebooting"
/sbin/reboot -nfi
EOF
chmod 755 /fix.sh
	fi

	echo
	echo "=== Next steps:"
	echo " - reboot system (automatic)"
	echo " - log-in to vHost ${_vhost} and execute:"
	echo "      virsh console bsul${_hostnum}"
	echo " - on VM console execute:"
	echo "      /fix.sh"
	read -p "Press [Enter] to reboot..."
	reboot

}

upgrade() {

	if [ ${_curmajver} -eq 7 ]; then
		echo "Option available only on RHEL 6.X"
		exit 1
	fi

	read -p "=== Verify that applications are not running (Oracle, SAP, etc). Press [Enter] to continue or [Ctrl-C] to interrupt."

	if [ $(cat /proc/mounts | grep -c "/dev/system${_hostnum}/install") -eq 0 ];then
		echo "=== Mounting installation LV..."
		mount /dev/system${_hostnum}/install /mnt
	fi

	if [ ! -f /mnt/.discinfo ]; then
		echo "=== Copy ISO content to /mnt directory..."
		echo "Run on bsux0020:"
	        echo "	rsync -avxu /export/RHEL${_targetver}_64/ bsul${_hostnum}a01:/mnt/"
		read -p "Press [Enter] to coninue..."
	fi

	echo "=== Uninstalling cluster..."
	yum -y remove corosync modcluster cman openais ricci corosynclib rgmanager openaislib clusterlib
	
	echo "=== Starting pre-upgrade assistant..."
	preupg -v
	read -p "Press [Enter] to continue..."
	sed -i '2iexit 0' /root/preupgrade/preupgrade-scripts/rename_network.sh

	echo "=== Starting upgrade..."
	redhat-upgrade-tool --device=/mnt -v
	read -p "Press [Enter] to continue..."

	echo "=== Remove old ssh keys from /home/root/.ssh/known_hosts on bsux0020"
	read -p "Press [Enter] to continue..."

	read -p "Press [Enter] to reboot..."
	reboot
}

post() {
	if [ ${_curmajver} -eq 6 ]; then
		echo "Option available only on RHEL 7.X"
		exit 1
	fi

	read -p "=== Verify that applications are not running (Oracle, SAP, etc). Press [Enter] to continue or [Ctrl-C] to interrupt."

	echo "=== Removing installation LV..."
	lvremove /dev/system${_hostnum}/install

	echo "=== Registering in Satellite..."
	rhnreg_ks --activationkey=${_regkey} --force
	read -p "Press [Enter] to continue..."

	echo "=== Removing unwanted packages..."
	yum -y remove boost-program-Options boost-regex boost-license1_53_0 boost-date-time acpid alsa-utils \
		cups cups-filesystem cups-filters cyrus-sasl fprintd fprintd-pam iptables-services libcgroup-tools \
		mcelog microcode_ctl portreserve ppl cloog-ppl ghostscript ghostscript-fonts arts strigi-libs compat-db.i686

	echo "=== Installing required packages..."
	yum -y install vm-dump-metrics rhncfg-client compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 bash-completion perl-autodie

	read -p "Install vwfs-orasys (required for Oracle RAC only!!!)? [N/y] " oraans
	[ -z ${oraans} ] && oraans="N"
	if [ ${oraans} = "y" -o ${oraans} = "Y" ]; then
		yum -y install vwfs-orasys
	fi

	echo "=== Updating system..."
	yum -y update
	read -p "=== Verify output above. Press [Enter] to continue or [Ctrl-C] to interrupt."

	echo "=== Retrieving configuration from Satellite"
	rhncfg-client get

	echo "=== Removing el6 packages..."
	for a in $(rpm -qa | grep el6) ; do rpm -e ${a} ; done
	yum -y downgrade nagios-common
	rpm -q --quiet fakeroot-libs && rpm -e fakeroot-libs
	echo "------------"
	rpm -qa | grep el6
	read -p "Press [Enter] to continue..."

	java8=$(cat /root/preupg-evidence/rpm.out | grep  java-1.8.0-openjdk-headless)

	if [ ${java8} != "" ]; then
	  rpm -q --quiet java-1.8.0-openjdk-headless
	  rc=$?
	  if [ ${rc} -eq 1 ]; then
	  	echo "=== Installing java-1.8.0-openjdk-headless"
		yum install -y  java-1.8.0-openjdk-headless
	  	read -p "Press [Enter] to continue..."
	  fi
	fi
	
	echo "=== Configuring GRUB2 bootloader..."
	cat > /etc/default/grub <<EOF
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL="serial console"
GRUB_SERIAL_COMMAND="serial --speed=115200"
GRUB_CMDLINE_LINUX="elevator=noop crashkernel=auto rd.lvm.lv=system${_hostnum}/root_lv console=ttyS0,115200n8 audit=1 transparent_hugepage=never"
GRUB_DISABLE_RECOVERY="true"
EOF
	grub2-install --grub-setup=/bin/true /dev/${_pridisk}
	grub2-mkconfig -o /boot/grub2/grub.cfg
	grub2-install /dev/${_pridisk}

	echo "=== Retrieving configuration from Puppet"
	puppet agent --test

	echo "=== Install Icinga agent..."
	echo "Log-in to bsux0020 and execute:"
	echo "    /export/software/icinga2/bin/manual_install.sh bsul${_hostnum} PROD"
	read -p "Press [Enter] to continue..."
	
	echo "=== Restore original /etc/fstab..."
	/bin/mv -f /etc/fstab /etc/fstab.tmp
	/bin/cp -f /etc/fstab.orig /etc/fstab
	read -p "Press [Enter] to continue..."
	
	echo "=== Creating /var/log/journal directory..."
	mkdir /var/log/journal

	javapkg=""
	rpm -q --quiet java-1.8.0-openjdk
	rc=$?
	[ $rc -eq 0 ] && javapkg="java-1.8.0-openjdk"
	rpm -q --quiet java-1.8.0-openjdk-headless
	rc=$?
	[ $rc -eq 0 ] && javapkg="${javapkg} java-1.8.0-openjdk-headless"
	if [ "${javapkg}" != "" ]; then
		echo "=== Repairing broken symlinks for java 1.8..."
		rm /var/lib/alternatives/java /var/lib/alternatives/jce* /var/lib/alternatives/jre_*
		rm $(for f in $(find /etc/alternatives /usr/lib/jvm /usr/lib/jvm-exports -maxdepth 1 -type l); do [ -e "$(readlink -f "$f")" ] || echo "$f"; done)
		yum -y reinstall "${javapkg}"
	fi

	echo "=== Updating udev rules..."
	for i in /etc/udev/rules.d/* ; do
		grep -q -c oracle ${i}
		rc=$?
		[ $rc -ne 0 ] && continue
		sed -i 's/SYSFS/ATTRS/g' ${i}
		sed -i 's/BUS=="scsi"/SUBSYSTEM=="block"/g' ${i}
		sed -i 's/\/sbin\/scsi_id/\/lib\/udev\/scsi_id/g' ${i}
	done
	udevadm trigger
	read -p "Please verify udev rules (journalctl -b) and press [Enter] to continue..."

	echo "=== Configuring PAM stack limit..."
	egrep -v "^#" /etc/security/limits.conf /etc/security/limits.d/* | grep -q stack
	rc=$?
	if [ $rc -ne 0 ]; then
		cat > /etc/security/limits.d/99-stack.conf << EOF
*          soft    stack     10240
*          hard    nproc     10240
EOF
		echo "PAM stack limit set to 10240."
	else
		read -p "Verify that PAM stack limits is set to 10240 or greater and press [Enter] to continue..."
	fi
	
	echo "=== Configuring backup..."
	if [ -f /usr/isbs/local/data/backup.cfg ] ; then
		sed -i '/^\/usr$/d' /usr/isbs/local/data/backup.cfg
	fi
	
	systemctl disable tsmsched
	systemctl stop tsmsched
	
	if [ -f /etc/init.d/dsmcad ] ; then
		/etc/init.d/dsmcad stop
		chkconfig --del dsmcad
		rm -f /etc/init.d/dsmcad
		cat > /etc/systemd/system/dsmcad.service << EOF
[Unit]
Description=IBM Tivoli Storage Manager Client dsmcad systemd-style sample service description
Documentation=http://www-01.ibm.com/support/knowledgecenter/SSGSG7_7.1.4/client/t_protect_wf.html?lang=en
After=local-fs.target network-online.target

[Service]
Type=forking
GuessMainPID=no
Environment="DSM_LOG=/opt/tivoli/tsm/client" "LD_LIBRARY_PATH=/opt/tivoli/tsm/client/ba/bin" "LC_ALL=en_US" "LANG=en_US"
ExecStart=/usr/bin/dsmcad
ExecStopPost=/bin/bash -c 'let i=0; while [[ (-n "$(ps -eo comm | grep dsmcad)") && ($i -le 10) ]]; do let i++; sleep 1; done'
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
		systemctl daemon-reload
		systemctl enable dsmcad
		systemctl start dsmcad
		systemctl status dsmcad
	fi	

	grep -q "SAP Database Administrator" /etc/passwd
	orasap=$?
	if [ ${orasap} -eq 0 ]; then
		cat > /etc/systemd/system/prole_ora.service << EOF
[Unit]
Description=IBM Tivoli Storage Manager for ERP prole daemon
After=network.target

[Service]
Type=simple
ExecStart=/opt/tivoli/tsm/tdp_r3/ora64/prole -p tdpr3ora64
Restart=on-failure

[Install]
WantedBy=default.target
EOF
		systemctl daemon-reload
		systemctl enable prole_ora
		systemctl start prole_ora
		systemctl status prole_ora
	fi

	if [ -f /opt/tivoli/tsm/client/api/bin64/libtsmxerces-c.so.28.0 ] ; then
		ln -s /opt/tivoli/tsm/client/api/bin64/libtsmxerces-c.so.28.0 /usr/lib64/libtsmxerces-c.so.28
	fi
	if [ -f /opt/tivoli/tsm/client/api/bin64/libtsmxerces-depdom.so.28.0 ] ; then
		ln -s /opt/tivoli/tsm/client/api/bin64/libtsmxerces-depdom.so.28.0 /usr/lib64/libtsmxerces-depdom.so.28
	fi
	ldconfig
	dsmc q fi
	read -p "Press [Enter] to continue..."
	
        echo "=== Enabling services..."
        for a in icinga2 ntpd puppet pxp-agent osad appss; do
        	echo "=== Enabling ${a}"
        	systemctl enable ${a}
        done
	read -p "Press [Enter] to continue..."
								
	
	echo "=== System hardening..."
	echo "Please execute on bsux0020:"
	echo "  export MAILLIST=yourmail"
	echo "  /usr/sys/inst.images/sec/isec.wrapper/all_platforms/isec_hardening_compliance_check.OS.single_node.sh ${_host}a01"
	
	echo "=== Remove old system from Red Hat Satellite..."
	read -p "Press [Enter] to continue..."

	echo "=== Please create Change for Backup & Recovery team with following descritpion:"
	echo "		Please rename /usr filespace to /RHEL6_usr"
	echo "	Set Change due time to 1 month."
	read -p "Press [Enter] to continue"	

	echo "=== Remove maintenance mode..."
	echo "Log-in on bsul0598 and execute:"
	echo "  /usr/lib64/nagios/plugins/send_to_icinga --removedowntime --hostname ${_host}"	
	read -p "Press [Enter] to continue..."

	echo "====== UPGRADE COMPLETED $(date +'%H:%M') ======="
	echo
	printwarn "Please verify that current version ($(lsb_release -s -r)) was requested."
	read -p "Press [Enter] to continue..."
	echo
	
	if [ -f /root/pcs.info ]; then
		printwarn "Please configure cluster..."
		cat /root/pcs.info
		read -p "Press [Enter] to continue..."

		echo
		printwarn "Please remove fencing definitions from /usr/isbs/local/data/xen-cluster-client.cfg on ${_vhost}"
		read -p "Press [Enter] to continue..."
	fi
	
	read -p "=== Verify output above. Press [Enter] to reboot or [Ctrl-C] to interrupt."
	reboot
}

usage () {
	echo "Usage: $0 <options>"
	echo "	Options:"
	echo "		precheck	- Verify VM before upgrade"
	echo "		backup		- Reboot and backup system"
	echo " 		prepare		- Prepare VM to upgrade"
	echo " 		upgrade		- Perform VM upgrade"
	echo " 		post		- Post-upgrade cleanup"
}

case "$1" in
	precheck)
		precheck
		;;
	backup)
		backup
		;;
	prepare)
		prepare
		;;
	upgrade)
		upgrade
		;;
	post)
		post
		;;
	*)
		usage
		exit 1 
esac
