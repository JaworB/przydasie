#!/bin/bash
usage="
Usage labenv.sh [options]
Options
	--vms start/stop		start or stop all kvm VMs on host (eg. ./labenv.sh --vms start)
	--auto on/off			enable or disable VMs autostart (eg. ./labenv.sh --auto on)
	--status				check current status of kvm VMs
	--clone					
	"

option=$1
param=$2
virsh_list=$(virsh list --all |grep test |awk '{print $2}')


vms () {
	if [ $param == "start" ];then
		for i in $virsh_list; do virsh start $i 2> /dev/null ; done
		echo "VMs started successfully"
	elif [ $param == "stop" ];then
		for i in $virsh_list; do (virsh shutdown $i 2> /dev/null); done 
		echo "VMs stopped successfully"
	else
		echo "Unrecognized param"
		echo "$usage"
	fi
}

auto () {
	if [ $param == "on" ];then
		for i in $virsh_list; do virsh autostart $i 2> /dev/null ; done
		echo "Enabled autostart for VMs"
	elif [ $param == "off" ];then
		for i in $virsh_list; do virsh autostart --disable $i 2> /dev/null ; done
		echo "Disabled autostart for VMs"
	fi
}

clone () {
	virsh list --all
	echo -n "Which VMs should be cloned?: "
	read vm_to_clone
	vmstate=$(virsh list --all |grep $vm_to_clone |awk '{print $3}')
	if [ $vmstate == "running" ];then
		echo -n "VM is currently running, should I shutdown VM?: y/n: "
		read answ
		case $answ in
		"y")
			virsh shutdown $vm_to_clone >> /dev/null
			echo "Shutting down $vm_to_clone, please wait"
			sleep 10
		;;
		"n")
			echo "Abort!"
			exit 0
		;;
		*)
			"Please answer y/n!"
		;;
		esac
	fi
	echo -n "Please provide name for cloned VM: "
	read clone_name
	echo -n "Chose path for new clone disk (eg. /vmstorage/test3.qcow2): "	
	read file_path
	test -f $file_path
	if [ $(echo $?) -eq 0 ];then
		echo "File exists, please remove it in second console"
		read -p "== Press enter to continue =="
	fi

	echo "You're about to clone $vm_to_clone, with name $clone_name on $file_path." 
	read -p "== Press enter to continue =="
	virt-clone --original $vm_to_clone --name $clone_name --file $file_path
	virsh start  $clone_name --console
	virsh start $vm_to_clone
}

remove () {
	virsh list --all
	echo -n "Which VMs should be remove?: "
	read vmname
	echo "You're about to remove $vmname with attached OS disk. Continue? y/n"
	read answ
	case $answ in
		"y")
			vmstate=$(virsh list --all |grep $vmname |awk '{print $3}')
			if [ $vmstate == "running" ];then
				echo -n "VM is currently running, should I shutdown VM?: y/n: "
				read answ
				case $answ in
				"y")
					virsh destroy $vmname
					disk=$(virsh domblklist $vmname |grep $vmname |awk '{print $2}')
					rm -f $disk
					virsh undefine $vmname
					echo "VM $vmname has been removed!"
					;;
				"n")
					echo "Abort!"
					exit 0
					;;
				*)
					echo "Please answer y/n!"
					;;
				esac
			else
				disk=$(virsh domblklist $vmname |grep $vmname |awk '{print $2}')
				rm -f $disk
				virsh undefine $vmname
				echo "VM $vmname has been removed!"
			fi
		;;
		"n")
			echo "Abort!"
			exit 0
		;;
		*)
			"Please answer y/n!"
		;;
	esac
}

case $option in
	--vms)
		vms
	;;
	--status)
		virsh list --all
	;;
	--auto)
		auto
	;;
	--clone)
		clone
	;;
	--remove)
		remove
	;;
	*)
		 echo "$usage"
	;;
esac
exit 0