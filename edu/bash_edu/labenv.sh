#!/bin/bash
selector=$1
virsh_list=$(virsh list --all |grep test |awk '{print $2}')
usage=$(echo "=== Chose option: start/stop ===")

labmanage () { 
	if [ $selector -z ];then
		echo $usage
		read selector
		if [ $selector == "start" ];then
			for i in $virsh_list; do virsh start $i ; done
			echo "Vms started"
		elif [ $selector == "stop" ];then
			for i in $virsh_list; do virsh shutdown $i; done
			echo "VMs shut off"
		else
			echo "Unrecognized option. Do the needfull."
			labmanage
		fi
	fi
}
labmanage
exit 0
