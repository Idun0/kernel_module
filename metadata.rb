name              'kernel_module'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'MIT'
description       'Load kernel modules'
version           '1.1.1'

%w(amazon centos debian fedora oracle redhat scientific suse opensuse opensuseleap ubuntu).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/kernel_module'
issues_url 'https://github.com/chef-cookbooks/kernel_module/issues'
chef_version '>= 12.7' if respond_to?(:chef_version)
