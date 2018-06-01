# -*- mode: ruby -*-
# vi: set ft=ruby :

box = {
  :virtualbox => 'ubuntu/xenial64',
  :libvirt => 'elastic/ubuntu-16.04-x86_64'
}

provider = (ENV['VAGRANT_DEFAULT_PROVIDER'] || :virtualbox).to_sym
puts "[INFO] Provider: #{provider} "

Vagrant.configure("2") do |config|
  config.vm.box =  box[provider]
  config.vm.hostname = "installer"
  config.vm.provision 'shell', :path => "postinstall.sh"

  config.vm.provider 'virtualbox' do |v|
    v.customize ["modifyvm", :id, "--memory", 1024 * 8]
    v.customize ["modifyvm", :id, "--cpus", 4]
  end
  config.vm.provider 'libvirt' do |v|
    v.memory = 1024 * 8
    v.cpus = 4
    v.nested = true
    v.cpu_mode = 'host-passthrough'
  end

  if ENV['http_proxy'] != nil and ENV['https_proxy'] != nil
    if not Vagrant.has_plugin?('vagrant-proxyconf')
      system 'vagrant plugin install vagrant-proxyconf'
      raise 'vagrant-proxyconf was installed but it requires to execute again'
    end
    config.proxy.http     = ENV['http_proxy'] || ENV['HTTP_PROXY'] || ""
    config.proxy.https    = ENV['https_proxy'] || ENV['HTTPS_PROXY'] || ""
    config.proxy.no_proxy = ENV['NO_PROXY'] || ENV['no_proxy'] || "127.0.0.1,localhost"
  end
end
