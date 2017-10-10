VAGRANT_API_VERSION = '2'
Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 1024
  end

  config.vm.define :master do |master|
    master.vm.box = 'ubuntu/xenial64'
    master.vm.host_name = 'master.local'
    master.vm.synced_folder 'saltstack/salt', '/srv/salt'
    master.vm.network 'private_network', ip: '192.168.10.30'

    master.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = 'saltstack/etc/master'
      salt.run_highstate = true
    end
  end

  config.vm.define :minion1 do |minion1|
    minion1.vm.box = 'ubuntu/xenial64'
    minion1.vm.host_name = 'minion.local'
    minion1.vm.synced_folder 'saltstack/salt', '/srv/salt'
    minion1.vm.network 'private_network', ip: '192.168.10.31'

    minion1.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = 'saltstack/etc/minion'
      salt.run_highstate = true
    end 
  end
end

