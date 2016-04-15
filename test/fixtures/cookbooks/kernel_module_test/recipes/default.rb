# ntfs, xfs, cifs, jffs2, coda

unless ::File.exist?('/tmp/kernel_module_first_run_done')
  %w(ntfs raid10 raid456 foo).each do |mod|
    ruby_block "check for module #{mod}" do
      block do
        `lsmod | grep -q #{mod}`
        abort "Precondition failed - #{mod}-module already loaded" if $?.exitstatus != 1
      end
    end
  end

  file '/tmp/kernel_module_first_run_done' do
    action :touch
  end
end

execute 'modprobe ntfs'

ruby_block 'check for module' do
  block do
    `lsmod | grep -q ntfs`
    abort 'The ntfs module should be loaded' if $?.exitstatus != 0
  end
end

kernel_module 'ntfs' do
  action :unload
end

ruby_block 'check for module' do
  block do
    `lsmod | grep -q ntfs`
    abort 'ntfs module did not unload' if $?.exitstatus != 1
  end
end

kernel_module 'ntfs' do
  action :blacklist
end

kernel_module 'raid10'

file '/etc/modprobe.d/foo.conf' do
  action :touch
end

kernel_module 'foo' do
  action :uninstall
end

node.default['kernel_modules'] = { 'raid456' => 'install' }

include_recipe 'kernel_module'
