# -*- mode: ruby -*-
# vi: set ft=ruby : 

boxes = [
#  { :name => :puppetmaster, :hostname => 'puppet.cway.com', :ip => '10.1.0.10', :cpus =>1, :memory => 1024 },
  { :name => :monserver, :hostname => 'monserver.cway.com', :ip => '192.168.60.11', :cpus =>1, :memory => 1024 },
  { :name => :client0, :hostname => 'client0.cway.com', :ip => "192.168.60.100", :cpus =>1, :memory => 512},
  { :name => :gitlab, :hostname => 'gitlab.cway.com', :ip => "192.168.60.200", :cpus =>1, :memory => 512}
]

Vagrant.configure("2") do |config|
    boxes.each do |opts|
        config.vm.define opts[:name] do |config|
        config.vm.box        = "debian71"
        config.vm.network :private_network, ip: opts[:ip]
        config.vm.hostname = opts[:hostname] if opts[:hostname] 
        config.vm.synced_folder "data", "/mydata"
        config.vm.synced_folder "puppet/files", "/etc/puppet/files"

        config.vm.provision :puppet do |puppet|
           puppet.manifest_file  = "site.pp"
           puppet.module_path = "puppet/modules"
           puppet.manifests_path = "puppet/manifests"
           puppet.options = "--hiera_config /mydata/hiera.yaml"  #puppet3 has Hiera built in
           puppet.options = "--fileserverconfig=/mydata/fileserver.conf"
        end

        config.vm.provider :virtualbox do |vb|
             vb.gui = false
             vb.customize ["modifyvm", :id, "--memory", opts[:memory] ] if opts[:memory]
             vb.customize ["modifyvm", :id, "--cpus", opts[:cpus] ] if opts[:cpus] 
        end

    end
  end
end
