# -*- mode: ruby -*-
# vi: set ft=ruby :

box = {
  :virtualbox => 'ubuntu/xenial64',
  :libvirt => 'elastic/ubuntu-16.04-x86_64'
}

require 'yaml'
idf = ENV.fetch('IDF', 'config/pdf.yml')
nodes = YAML.load_file(idf)

provider = (ENV['VAGRANT_DEFAULT_PROVIDER'] || :virtualbox).to_sym
puts "[INFO] Provider: #{provider} "

if ENV['no_proxy'] != nil or ENV['NO_PROXY']
  $no_proxy = ENV['NO_PROXY'] || ENV['no_proxy'] || "127.0.0.1,localhost"
  nodes.each do |node|
    $no_proxy += "," + node['ip']
  end
  $subnet = "192.168.121"
  # NOTE: This range is based on vagrant-libvirt network definition CIDR 192.168.121.0/27
  (1..31).each do |i|
    $no_proxy += ",#{$subnet}.#{i}"
  end
end


Vagrant.configure("2") do |config|
  config.vm.box =  box[provider]

  if ENV['http_proxy'] != nil and ENV['https_proxy'] != nil
    if not Vagrant.has_plugin?('vagrant-proxyconf')
      system 'vagrant plugin install vagrant-proxyconf'
      raise 'vagrant-proxyconf was installed but it requires to execute again'
    end
    config.proxy.http     = ENV['http_proxy'] || ENV['HTTP_PROXY'] || ""
    config.proxy.https    = ENV['https_proxy'] || ENV['HTTPS_PROXY'] || ""
    config.proxy.no_proxy = $no_proxy
    config.proxy.enabled = { docker: false }
  end

  nodes.each do |node|
    config.vm.define node['name'] do |nodeconfig|
      nodeconfig.vm.hostname = node['name']
      nodeconfig.ssh.insert_key = false
      nodeconfig.vm.network :private_network, :ip => node['ip'], :type => :static
      [:virtualbox, :libvirt].each do |provider|
        nodeconfig.vm.provider provider do |p, override|
          p.cpus = 4
          p.memory = 20480
        end
      end
      nodeconfig.vm.provider 'libvirt' do |v|
        v.nested = true
        v.cpu_mode = 'host-passthrough'
        v.management_network_address = "192.168.121.0/27"
      end
    end
  end
  sync_type = "virtualbox"
  if provider == :libvirt
    if not Vagrant.has_plugin?('vagrant-libvirt')
      system 'vagrant plugin install vagrant-libvirt'
      raise 'vagrant-libvirt was installed but it requires to execute again'
    end
    sync_type = "nfs"
  end
  config.vm.define :installer, primary: true, autostart: false do |installer|
    installer.vm.hostname = "multicloud"
    installer.ssh.insert_key = false
    installer.vm.synced_folder './etc', '/etc/kolla/', create: true
    installer.vm.network :private_network, :ip => "10.10.13.2", :type => :static
    installer.vm.provision 'shell', :path => "postinstall.sh"
  end
end
