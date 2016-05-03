include_recipe 'kernel_module'

kernel_module 'install_test_mod'

kernel_module 'load_test_mod' do
  action :load
end

kernel_module 'blacklist_test_mod' do
  action :blacklist
end

kernel_module 'unload_test_mod' do
  action :unload
end

kernel_module 'uninstall_test_mod' do
  action :uninstall
end

kernel_module 'install_test_mod_custom' do
  load_dir '/etc/modules.d'
end

kernel_module 'blacklist_test_mod_custom' do
  action :blacklist
  unload_dir '/etc/modules.d'
end
