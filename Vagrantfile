# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.username = "root"
  config.ssh.private_key_path = "./ssh/id_rsa"

  { 'db1'=>'centos7',
    'web1'=>'centos6',
    'web2'=>'centos6'
  }.each do |name,os|
    config.vm.define name do |v|
      v.vm.hostname = name
      v.vm.provider "docker" do |d|
        d.build_dir = "./docker/#{os}"
        d.has_ssh = true
      end
    end
  end
end
