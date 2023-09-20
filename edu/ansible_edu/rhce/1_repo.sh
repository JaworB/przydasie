#!/bin/bash
ansible -m yum_repository -a 'name=Docker_repo description=opis baseurl=https://download.fedoraproject.org/pub/epel/// gpgcheck=yes gpgkey=https://download.docker.com/linux/fedora/gpg enabled=yes' all 
ansible -m yum_repository -a 'name=Docker_repo2 description=opis baseurl=https://download.fedoraproject.org/pub/epel/// gpgcheck=yes gpgkey=https://download.docker.com/linux/fedora/gpg enabled=yes' all 
