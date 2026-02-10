#!/bin/bash
conf_file=./config
backup_dir=/backup
backup_content=/backup/
dest_dir=$backup_dir/backup_$(date +%Y%m%d)
fs_to_backup="docker_services vmstorage"
dir_to_construct="$dest_dir $dest_dir/$fs_to_backup"

#Create destination directories for files
create_dirs (){
  mkdir $dest_dir
  for fs in $fs_to_backup;do 
    mkdir $dest_dir/$fs
  done
  echo "=== Directories created under $dest_dir ==="
  ls $dest_dir
}

#Remove .tar files older than 21 days
remove_old_files (){
	echo "=== Looking for old backup files ==="
	find $backup_content -mtime +21 -name backup*
	echo "=== Removing files: ==="
	find $backup_content -mtime +21 -name backup* -exec rm {} \;
}

#Remove old vm xml profiles. Create and backup new files.
virsh_dump () {
    vm_list=$(virsh list --all |awk '{print $2}'|sed 's/Name//')
    rm -f /vmstorage/xml/*
    for vm in $vm_list; do 
			vmstate=$(virsh list --all |grep $vm |awk '{print $3}')
      virsh dumpxml $vm >> /vmstorage/xml/$vm.xml
		done
    echo "=== VMs xmls backed up ==="
}

#Copy files to dest_dir.
copy () {
  echo "=== Backup started ==="
  for fs in $fs_to_backup;do
    echo "=== Backup of $fs in progress ==="
    cp -pr /$fs/* $dest_dir/$fs
    echo "Backup of $fs finished"
    done
  echo "Backup process successfully finished"
}

#Compress files into new .tar.gz file
archive () {
  echo "Compressing $dest_dir to $dest_dir.tar.gz"
  tar -zcf $dest_dir.tar.gz $dest_dir
  rm -rf $dest_dir
}

create_dirs
remove_old_files
virsh_dump
copy
archive
