#!/bin/bash
conf_file=./config
backup_dir=/backup
dest_dir=$backup_dir/backup_$(date +%Y%m%d)
fs_to_backup="docker_services vmstorage"
dir_to_construct="$dest_dir $dest_dir/$fs_to_backup"

#Create destination directories for files
create_dirs (){
  mkdir $dest_dir
  for fs in $fs_to_backup;do 
    mkdir $dest_dir/$fs
  done
  echo "=== Directtories created under $dest_dir ==="
  ls $dest_dir
}

virsh_dump () {
    vm_list=$(virsh list --all |awk '{print $2}'|sed 's/Name//')
    for vm in $vm_list; do 
			vmstate=$(virsh list --all |grep $vm |awk '{print $3}')
#			if [ $vmstate == "running" ];then
#				#virsh shutdown $vm > /dev/null
#				#temoporary disabld shutdown check for hosts
#			fi
      rm -f /vmstorage/xml/*
      virsh dumpxml $vm >> /vmstorage/xml/$vm.xml
		done
    echo "=== VMs xmls backed up ==="
}

copy () {
  echo "=== Backup started ==="
  for fs in $fs_to_backup;do
    echo "=== Backup of $fs in progress ==="
    cp -pr /$fs/* $dest_dir/$fs
    echo "Backup of $fs finished"
    done
  echo "Backup process successfully finished"
  lab vms start
}

archive () {
  echo "Compressing $dest_dir to $dest_dir.tar.gz"
  tar -zcf $dest_dir.tar.gz $dest_dir
  rm -rf $dest_dir
}

create_dirs
virsh_dump
copy
archive
