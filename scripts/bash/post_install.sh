#!/bin/bash

JAWOR
ip a
sudo dnf remove nano*
sudo dnf install vim-default*
vim /etc/selinux/config
sudo vim /etc/selinux/config
vim /etc/ssh/sshd_config
sudo vim /etc/ssh/sshd_config
systemctl restart sshd
history
dnf provides nmtui
sudo dnf install -y NetworkManager-tui
nmtui
sudo reboot
sudo su -
ssh-keygen
ssh-copy-id root@localhost
ssh-copy-id -p 2229 root@localhost
sudo su -
sudo vim /etc/fstab
umount /mnt
sudo umount /mnt
mkdir /share /docker_services /vmstorage
sudo mkdir /share /docker_services /vmstorage
sudo mount -a
df -h
cp /share/.bashrc ./
ls -l
histoy
history
lsblk
sudo mount /dev/share_vg/lv01 /mnt
cat /mnt/git_repos/przydasie/backup/fstab.txt
#cp /share/git_repos/przydasie/scripts/ansible/paczki/files/neofetch/config.conf /home/jawor/.config/
neofetch
sudo neofetch
sudo dnf install -y neofetch
neofetch
cp /share/git_repos/przydasie/scripts/ansible/paczki/files/neofetch/config.conf /home/jawor/.config/neofetch/
neofetch


##############root
ip a
nmcli connection modify Wired\ connection\ 1 ipv4.addresses 192.168.0.170/24
dnf install vim -y
systemctl status sshd
systemctl enable --now
systemctl enable --now sshd
passwd
ls
ls -la
vim .ssh/authorized_keys
cp .ssh/authorized_keys /home/jawor/.ssh/
chown jawor:jawor /home/jawor/.ssh/authorized_keys
visudo -f /etc/sudoers
ln -s /share/git_repos/przydasie/ przydasie
#/share/git_repos/przydasie/scripts/bash/kvm_env_manager.sh
vim .bashrc
cat /home/jawor/.bash_history
ip a
nmtui
nmcli connection modify Wired\ connection\ 1 -ipv4.addresses 192.168.0.136/24
nmcli connection show
nmcli connection modify Wired\ connection\ 1 autoconnect no ; nmcli connection modify ext_bridge autoconnect yes ; reboot
ip a
dnf install samba -y
cp przydasie/backup/smb.conf /etc/samba/smb.conf
smbpasswd
smbpasswd -u
smbpasswd -a
smbpasswd -a jawor
systemctl restart smb.service
systemctl enable smb.service
smbstatus
firewall-cmd --add-service=samba
firewall-cmd --add-service=samba --permanent
firewall-cmd --reload
systemctl restart smb.service
dnf install @virtualization
systemctl enable --now libvirt
dnf install libvir -y
dnf install libvirtd -y
dnf install libvirt -t
dnf install libvirt -y
systemctl enable --now libvirt
systemctl enable --now libvirtd
virsh net-list --all
ip a
dnf install xrdp -y ; firewall-cmd --add-port=3389/tcp --permanent ;firewall-cmd --reload
cat /home/jawor/.bash_history


#### post clone
rm -f /vmstorage/xml/*
    3  hostnamectl set-hostname fedora37
    4  systemctl disable --now systemd-resolved.service
    5  unlink /etc/resolv.conf
   10  echo "nameserver    192.168.0.180" >> /etc/resolv.conf
   14  dnf install git ansible NetworkManager-tui -y