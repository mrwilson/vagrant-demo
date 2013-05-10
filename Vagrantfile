Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.synced_folder "salt/roots/", "/srv/"
  
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion.conf"
    salt.run_highstate = true
  end
end
