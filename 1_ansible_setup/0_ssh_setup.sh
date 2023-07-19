#!/bin/bash

ssh_pub_file="/home/t/.ssh/id_rsa_ansible.pub"
ssh_known_hosts_file="/home/t/.ssh/known_hosts"
ssh_password="@@@@@@@@@@"

ssh-keygen -t rsa

for ((ip=85; ip<=89; ip++))
do
    ip_addr="192.168.10.$ip"
    sshpass -p $ssh_password ssh-keyscan $ip_addr >> $ssh_known_hosts_file
    sshpass -p $ssh_password ssh-copy-id -i $ssh_pub_file root@$ip_addr
done
