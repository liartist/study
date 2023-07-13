# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_download_insecure = true
  config.vm.box_check_update = false
  config.vm.boot_timeout = 600

  NodeCount = 3

  # Kubernetes Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |node|
      node.vm.box = "ubuntu/focal64"
      node.vm.hostname = "worker#{i}"
      node.vm.network "private_network", ip: "172.16.16.20#{i}"
      node.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 2048
        v.cpus = 2
      end
      config.vm.provision "shell", inline: <<-SHELL
        sudo apt update
        sudo apt install -y vim ssh
        sudo apt upgrade -y
        if [ -e /etc/ssh/sshd_config ]; then
          sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
          sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
        fi
      SHELL
    end
  end

  config.vm.define "master" do |node|
    node.vm.box = "ubuntu/focal64"
    node.vm.hostname = "master"
    node.vm.network "private_network", ip: "172.16.16.200"
    node.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.memory = 2048
      v.cpus = 2
    end
    config.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y vim ssh
      sudo apt upgrade -y
      if [ -e /etc/ssh/sshd_config ]; then
        sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      fi
    SHELL
  end

  config.vm.define "manager" do |node|
    node.vm.box = "ubuntu/focal64"
    node.vm.hostname = "manager"
    node.vm.network "private_network", ip: "172.16.16.100"
    node.vm.provider "virtualbox" do |v|
      v.name = "manager"
      v.memory = 2048
      v.cpus = 2
    end
    config.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y vim ssh ansible
      sudo apt upgrade -y
      if [ -e /etc/ssh/sshd_config ]; then
        sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      fi
      if [ -e /etc/ansible/hosts ]; then
        echo "[master]
master ansible_host=172.16.16.200 ansible_user=root

[worker]
worker1 ansible_host=172.16.16.201 ansible_user=root
worker2 ansible_host=172.16.16.202 ansible_user=root
worker3 ansible_host=172.16.16.203 ansible_user=root" | sudo tee -a /etc/ansible/hosts > /dev/null
      fi
      echo | ssh-keygen -q -N ''
    SHELL
  end
end
