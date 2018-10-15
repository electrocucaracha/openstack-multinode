# -*- mode: ruby -*-
# vi: set ft=ruby :

box = {
  :virtualbox => { :name => 'elastic/ubuntu-16.04-x86_64', :version => '20180708.0.0' },
  :libvirt => { :name => 'elastic/ubuntu-16.04-x86_64', :version=> '20180210.0.0'}
}

require 'yaml'
pdf = File.dirname(__FILE__) + '/config/pdf.yml'
nodes = YAML.load_file(pdf)

provider = (ENV['VAGRANT_DEFAULT_PROVIDER'] || :virtualbox).to_sym
puts "[INFO] Provider: #{provider} "

if ENV['no_proxy'] != nil or ENV['NO_PROXY'] != nil
  $no_proxy = ENV['NO_PROXY'] || ENV['no_proxy'] || "127.0.0.1,localhost"
  nodes.each do |node|
    $no_proxy += "," + node['nics']['tunnel_ip']
    if node['nics'].has_key? "storage_ip"
      $no_proxy += "," + node['nics']['storage_ip']
    end
  end
  $subnet = "192.168.121"
  # NOTE: This range is based on vagrant-libvirt network definition CIDR 192.168.121.0/27
  (1..31).each do |i|
    $no_proxy += ",#{$subnet}.#{i}"
  end
  # NOTE: This is the kolla_internal_vip_address value
  $no_proxy += ",10.10.13.3"
end


Vagrant.configure("2") do |config|
  config.vm.box =  box[provider][:name]
  config.vm.box_version = box[provider][:version]

  if Vagrant.has_plugin?('vagrant-proxyconf')
    if ENV['http_proxy'] != nil or ENV['HTTP_PROXY'] != nil or ENV['https_proxy'] != nil or ENV['HTTPS_PROXY'] != nil
      config.proxy.http     = ENV['http_proxy'] || ENV['HTTP_PROXY'] || ""
      config.proxy.https    = ENV['https_proxy'] || ENV['HTTPS_PROXY'] || ""
      config.proxy.no_proxy = $no_proxy
      config.proxy.enabled = { docker: false }
    end
  end

  nodes.each do |node|
    config.vm.define node['name'] do |nodeconfig|
      nodeconfig.vm.hostname = node['name']
      nodeconfig.ssh.insert_key = false
      nodeconfig.vm.network :private_network, :ip => node['nics']['tunnel_ip'], :type => :static # Tunnel Network - This interface is used by Neutron for vm-to-vm traffic over tunneled networks (like VxLan).
      if node['nics'].has_key? "storage_ip"
        nodeconfig.vm.network :private_network, :ip => node['nics']['storage_ip'], :type => :static # Storage Network - This interface is used virtual machines to communicate to Ceph.
      end
      if node['roles'].include?('network')
        nodeconfig.vm.network :private_network, ip: '0.0.0.0', auto_network: true  # External Network - This is the raw interface given to neutron as its external network port.
      end
      [:virtualbox, :libvirt].each do |provider|
        nodeconfig.vm.provider provider do |p, override|
          p.cpus = node['cpus']
          p.memory = node['memory']
        end
      end

      # Volumes
      nodeconfig.vm.provider 'virtualbox' do |v|
        if node.has_key? "volumes"
          node['volumes'].each do |volume|
            $volume_file = "#{node['name']}-#{volume['name']}.vdi"
            unless File.exist?($volume_file)
              v.customize ['createmedium', 'disk', '--filename', $volume_file, '--size', volume['size']]
            end
            v.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', $volume_file]
          end
        end
      end
      nodeconfig.vm.provider 'libvirt' do |v|
        v.nested = true
        v.cpu_mode = 'host-passthrough'
        v.management_network_address = "192.168.121.0/27" # Management Network - This interface is used by OpenStack services and databases to communicate to each other.
        config.vm.provision 'shell' do |sh|
          sh.path =  "node.sh"
          if node.has_key? "volumes"
            $volume_mounts_dict = ''
            node['volumes'].each do |volume|
              $volume_mounts_dict += "#{volume['name']}=#{volume['mount']},"
              $volume_file = "./#{node['name']}-#{volume['name']}.qcow2"
              v.storage :file, :bus => 'sata', :device => volume['name'], :size => volume['size']
            end
            sh.args = ['-v', $volume_mounts_dict[0...-1]]
          end
        end
        if node['roles'].include?('registry')
          nodeconfig.vm.provision 'shell', :path => "registry.sh"
          nodeconfig.vm.synced_folder './etc/kolla/', '/etc/kolla/', create: true
        end
      end
    end
  end

  config.vm.define :undercloud, primary: true, autostart: false do |undercloud|
    undercloud.vm.provider 'libvirt' do |v|
        v.management_network_address = "192.168.121.0/27"
    end
    undercloud.vm.hostname = "undercloud"
    undercloud.vm.provision 'shell', :path => "undercloud.sh"
    undercloud.vm.synced_folder './etc/kolla-ansible/', '/etc/kolla/', create: true
  end
end
