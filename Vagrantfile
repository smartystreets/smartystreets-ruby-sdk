VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true
  config.vm.box = "boxcutter/ubuntu1404"
  config.vm.synced_folder "~/.identity", "/home/vagrant/.identity", create: true
  config.vm.synced_folder "~/.gnupg", "/home/vagrant/.gnupg", create: true
  config.vm.provision "shell", path: "https://s3-us-west-1.amazonaws.com/raptr-us-west-1/baseline/roles/vagrant"

  # box-specific
  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", inline: "apt-get install -y ruby" # Installs ruby 1.9 but we should install ruby 2.4...
  config.vm.provision "shell", inline: "apt-get install -y ruby git"
  config.vm.provision "shell", inline: "gem install minitest"
  config.vm.synced_folder "~/.gem", "/home/vagrant/.gem", create: true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
  end
end
