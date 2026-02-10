#/bin/bash!
def_address="192.168.0.101/24"
new_address=$(ip a |grep 192|grep -v 101|awk '{print $2}'| sed 's/\/24//')
def_con_name="enp1s0"
disable_def_address=$(nmcli connection modify $def_con_name -ipv4.addresses $def_address)
hostname=$1

ssh -o StrictHostKeyChecking=no -p 2229 sandbox "echo '$new_address    $hostname' >> /etc/hosts"
echo "$hostname    $new_address"
$disable_def_address
hostnamectl set-hostname $1
rm ./post_clone.sh
reboot