name              'kernel_module'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'MIT'
description       'Load kernel modules'
version           '1.1.0'

supports          'ubuntu'
supports          'debian'

source_url 'https://github.com/chef-cookbooks/kernel_module'
issues_url 'https://github.com/chef-cookbooks/kernel_module/issues'
chef_version '>= 12.7' if respond_to?(:chef_version)
