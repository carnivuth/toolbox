Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/jammy64'
  config.ssh.insert_key = true

  config.vm.provider "virtualbox" do |v|
#    v.linked_clone = true
    v.memory = 4096
    v.cpus = 2
  end

  # edgex runtime node
  config.vm.define 'test' do |machine|
    machine.vm.hostname = 'test'
    machine.vm.network 'forwarded_port', id: 'ssh', host: 2221, guest: 22
    config.vm.synced_folder ".", "/home/vagrant/toolbox"

  end
end
