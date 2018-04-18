include_recipe 'kernel_module'

kernel_module 'parport'

kernel_module 'lp' do
  action :load
end

kernel_module 'appletalk' do
  action :blacklist
end

kernel_module 'l2tp_ppp' do
  action :unload
end

kernel_module 'atm' do
  action :uninstall
end

kernel_module 'install_test_mod_custom' do
  load_dir '/etc/modules.d'
end

kernel_module 'blacklist_test_mod_custom' do
  action :blacklist
  unload_dir '/etc/modules.d'
end
