require_relative '../spec_helper'

describe 'kernel_module' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04',
      step_into: 'kernel_module'
    ) do |node|
      node.set['kernel_modules'] = {'attribute_test_mod' => 'nothing' }
    end.converge('kernel_module_test::default')
  end

  let(:attribute_mod){ 'attribute_test_mod' }
  let(:install_mod){ 'install_test_mod' }
  let(:load_mod){ 'load_test_mod' }
  let(:blacklist_mod){ 'blacklist_test_mod' }
  let(:unload_mod){ 'unload_test_mod' }
  let(:uninstall_mod){ 'uninstall_test_mod' }
  let(:custom_install_mod){ 'install_test_mod_custom' }
  let(:custom_blacklist_mod){ 'blacklist_test_mod_custom' }
  let(:custom_mods_dir){ '/etc/modules.d' }

  before do
    stub_command("lsmod | grep #{attribute_mod}").and_return(true)
    stub_command("lsmod | grep #{install_mod}").and_return(true)
    stub_command("lsmod | grep #{load_mod}").and_return(true)
    stub_command("lsmod | grep #{blacklist_mod}").and_return(true)
    stub_command("lsmod | grep #{unload_mod}").and_return(true)
    stub_command("lsmod | grep #{uninstall_mod}").and_return(true)
    stub_command("lsmod | grep #{custom_install_mod}").and_return(true)
    stub_command("lsmod | grep #{custom_blacklist_mod}").and_return(true)
  end

  context 'common' do

    it 'can execute module actions defined in node attributes' do
      expect(chef_run.kernel_module(attribute_mod)).to do_nothing
    end

    it 'can blacklist modules with custom directories' do
      expect(chef_run).to blacklist_kernel_module(custom_blacklist_mod)
      expect(chef_run).to create_file("#{custom_mods_dir}/blacklist_#{custom_blacklist_mod}.conf").with_content("blacklist #{custom_blacklist_mod}")
    end


    it 'can blacklist kernel modules' do
      expect(chef_run).to blacklist_kernel_module(blacklist_mod)
      expect(chef_run).to create_file("/etc/modprobe.d/blacklist_#{blacklist_mod}.conf").with_content("blacklist #{blacklist_mod}")
    end

    it 'can install modules to custom directories' do
      expect(chef_run).to install_kernel_module(custom_install_mod)
      expect(chef_run).to create_directory(custom_mods_dir).with(recursive: true)
      expect(chef_run).to create_file("#{custom_mods_dir}/#{custom_install_mod}.conf").with_content(custom_install_mod)
    end

    it 'can register modules to be installed and loaded' do
      expect(chef_run).to install_kernel_module(install_mod)
      expect(chef_run).to create_directory('/etc/modules-load.d').with(recursive: true)
      expect(chef_run).to create_file("/etc/modules-load.d/#{install_mod}.conf").with_content(install_mod)
      expect(chef_run.file("/etc/modules-load.d/#{install_mod}.conf")).to notify("execute[update-initramfs]").to(:run)
      expect(chef_run.execute('update-initramfs')).to do_nothing
    end

    it 'can uninstall kernel modules' do
      expect(chef_run).to uninstall_kernel_module(uninstall_mod)
      expect(chef_run).to delete_file("/etc/modules-load.d/#{uninstall_mod}.conf")
      expect(chef_run).to delete_file("/etc/modprobe.d/blacklist_#{uninstall_mod}.conf")
      expect(chef_run.file("/etc/modules-load.d/#{uninstall_mod}.conf")).to notify("execute[update-initramfs]").to(:run)
      expect(chef_run.execute('update-initramfs')).to do_nothing
    end

    it 'can load kernel modules' do
      expect(chef_run).to load_kernel_module(load_mod)
    end

    it 'can unload kernel modules' do
      expect(chef_run).to unload_kernel_module(unload_mod)
    end

  end

  context 'module already loaded' do

    it 'can register modules to be installed and loaded without re-probing' do
      expect(chef_run).to_not run_execute("modprobe #{install_mod}")
    end

    it 'can uninstall kernel modules and un-probe' do
      expect(chef_run).to run_execute("modprobe -r #{uninstall_mod}")
    end

    it 'can load kernel modules that are already loaded without re-probing' do
      expect(chef_run).to_not run_execute("modprobe #{load_mod}")
    end

    it 'can unload kernel modules that are already loaded and un-probe' do
      expect(chef_run).to run_execute("modprobe -r #{unload_mod}")
    end

    it 'can blacklist kernel modules and unprobe if already loaded' do
      expect(chef_run).to run_execute("modprobe -r #{blacklist_mod}")
    end
  end

  context 'module not already loaded' do

    before do
      stub_command("lsmod | grep #{install_mod}").and_return(false)
      stub_command("lsmod | grep #{load_mod}").and_return(false)
      stub_command("lsmod | grep #{attribute_mod}").and_return(false)
      stub_command("lsmod | grep #{blacklist_mod}").and_return(false)
      stub_command("lsmod | grep #{unload_mod}").and_return(false)
      stub_command("lsmod | grep #{uninstall_mod}").and_return(false)
      stub_command("lsmod | grep #{custom_install_mod}").and_return(false)
      stub_command("lsmod | grep #{custom_blacklist_mod}").and_return(false)
    end

    it 'can register modules to be installed and loaded' do
      expect(chef_run).to run_execute("modprobe #{install_mod}")
      expect(chef_run).to run_execute("modprobe #{custom_install_mod}")
    end

    it 'can load kernel modules not already loaded' do
      expect(chef_run).to run_execute("modprobe #{load_mod}")
    end

    it 'can uninstall kernel modules and will not unprobe modules not loaded' do
      expect(chef_run).to_not run_execute("modprobe -r #{uninstall_mod}")
    end

    it 'can unload kernel modules that are not already loaded' do
      expect(chef_run).to_not run_execute("modprobe -r #{unload_mod}")
    end

    it 'can blacklist kernel modules that are not installed' do
      expect(chef_run).to_not run_execute("modprobe -r #{blacklist_mod}")
      expect(chef_run).to_not run_execute("modprobe -r #{custom_blacklist_mod}")
    end
  end

end
