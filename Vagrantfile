Vagrant.configure('2') do |config|
  config.vm.box = 'debian/bookworm64'
  config.ssh.insert_key = true
  config.vm.provider "virtualbox" do |v|
    #    v.linked_clone = true
    v.memory = 4096
    v.cpus = 2
  end

  # edgex runtime node
  config.vm.define 'toolbox-test' do |machine|
    machine.vm.hostname = 'toolbox-test'
    machine.vm.network 'forwarded_port', id: 'ssh', host: 2221, guest: 22
    config.vm.synced_folder ".", "/home/vagrant/toolbox"

  end

  # provisioning
  $script = <<-'SCRIPT'
  sudo apt-get update
  cd ~/toolbox
  ./toolbox.sh
  SCRIPT
  config.vm.provision "shell", inline: $script, privileged: false
end
