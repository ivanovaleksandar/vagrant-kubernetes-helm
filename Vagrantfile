VAGRANT_API_VERSION = '2'
Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 2048
  end

  config.vm.define :helm do |helm|
    helm.vm.box = 'ubuntu/xenial64'
    helm.vm.host_name = 'helm.local'
    helm.vm.synced_folder 'saltstack/salt', '/srv/salt'
    helm.vm.network 'private_network', ip: '192.168.10.30'


    helm.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = 'saltstack/etc/minion'
      salt.run_highstate = true
    end
  end
end

