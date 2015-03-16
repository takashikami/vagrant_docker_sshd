# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.username = "root"
  config.ssh.private_key_path = "./ssh/id_rsa"

  config.vm.define "sshd01" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "."
      #d.has_ssh = true
      #d.ports = ["22"]
    end
  end
  config.vm.define "sshd02" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "./centos7"
      #d.has_ssh = true
      #d.ports = ["22"]
    end
  end
  config.vm.define "sshd03" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "./ubuntu"
      #d.has_ssh = true
      #d.ports = ["22"]
    end
  end
end
