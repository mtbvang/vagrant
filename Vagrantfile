# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Configure multiple machines. Anything in the machine config block only applies to that machine.
  # Any configuration out side of the machine blocks will be applied to all.

  config.vm.define "ruby1" do |r1|
    r1.vm.box = "lucid32"
    r1.vm.box_url = "http://192.168.36.131/lucid32.box"
    # vagrant.vm.box_url = "http://files.vagrantup.com/precise64.box"
    r1.vbguest.auto_update = false

    # Run shell provisioner to install puppet and install required modules.
    r1.vm.provision :shell, :path => "shell/bootstrap.sh"
    r1.vm.provision :shell, :path => "shell/build.sh", :args => "1-0-stable", :privileged => false
    r1.vm.provision :shell, :inline => "apt-get install -y git-core"

    r1.vm.provider "virtualbox" do |vb|
      # Headless mode boot
      vb.gui = false
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "768"]
    end
  end

  config.vm.define "precise" do |l|
    l.vm.box = "precise32"
    l.vm.box_url = "http://192.168.36.131/precise32.box"
    # l.vm.box_url = "http://files.vagrantup.com/precise64.box"
    l.vbguest.auto_update = false

    # Run shell provisioner to install puppet and install required modules.
    l.vm.provision :shell, :path => "shell/bootstrap.sh"
    l.vm.provision :shell, :inline => "apt-get install -y git"
    l.vm.provision :shell, :path => "shell/install-rvm.sh",  :args => "stable"
    l.vm.provision :shell, :path => "shell/install-ruby.sh", :args => "2.0.0 rails haml"
    l.vm.provision :shell, :path => "shell/build.sh", :args => "/vagrant_data/rails/myapp", :privileged => false

    l.vm.provider "virtualbox" do |vb|
      # Headless mode boot
      vb.gui = false
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "768"]
    end
  end

  config.vm.define "trusty" do |t|
    t.vm.box = "ubuntu-14.04-amd64-vbox-desktop"
    t.vm.box_url = "http://192.168.36.131/ubuntu-14.04-amd64-vbox-desktop.box"
    t.vbguest.auto_update = false

    # Run shell provisioner to install puppet and install required modules.
    t.vm.provision :shell, :path => "vagrant/shell/bootstrap.sh"
    t.vm.provision :shell, :inline => "apt-get install -y git"
    t.vm.provision :shell, :path => "vagrant/shell/install-rvm.sh",  :args => "stable"
    t.vm.provision :shell, :path => "vagrant/shell/install-ruby.sh", :args => "2.0.0 rails haml"
    t.vm.provision :shell, :path => "vagrant/shell/build.sh", :args => "/vagrant", :privileged => false

    t.vm.provider "virtualbox" do |vb|
      # Headless mode boot
      vb.gui = false
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", 4]
    end
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "/home/dev/code", "/vagrant_data"

end
