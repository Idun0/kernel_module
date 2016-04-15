#
# Cookbook Name:: kernel_module
# Resource:: default
#
# Copyright 2016, Shopify Inc.

property :name, String, name_attribute: true

# Load kernel module, and ensure it loads on reboot
action :install do
  template "/etc/modprobe.d/#{name}.conf" do
    source 'module.conf.erb'
    cookbook 'kernel_module'
    variables({
      :blacklisted => false,
      :module      => name
    })
    notifies :run, 'execute[update-initramfs]'
  end

  execute 'update-initramfs' do
    command 'update-initramfs -u'
    action :nothing
  end

  new_resource.run_action(:load)
end

# Unload module and remove module config, so it doesn't load on reboot.
action :uninstall do
  file "/etc/modprobe.d/#{name}.conf" do
    action :delete
    notifies :run, 'execute[update-initramfs]'
  end

  execute 'update-initramfs' do
    command 'update-initramfs -u'
    action :nothing
  end

  new_resource.run_action(:unload)
end

# Blacklist kernel module
action :blacklist do
  template "/etc/modprobe.d/#{name}.conf" do
    source 'module.conf.erb'
    cookbook 'kernel_module'
    variables({
      :blacklisted => true,
      :module      => name
    })
    notifies :run, 'execute[update-initramfs]'
  end

  execute 'update-initramfs' do
    command 'update-initramfs -u'
    action :nothing
  end

  new_resource.run_action(:unload)
end

# Load kernel module
action :load do
  execute "modprobe #{new_resource.name}" do
    not_if "lsmod | grep #{new_resource.name}"
  end
end

# Unload kernel module
action :unload do
  execute "modprobe -r #{new_resource.name}" do
    only_if "lsmod |grep #{new_resource.name}"
  end
end
