# kernel_module Cookbook CHANGELOG

This file is used to list changes made in each version of the kernel_module cookbook.
## 1.1.3 (2019-01-25)

- Added New Resources Property mod_params

## 1.1.2 (2018-09-04)

- Switch to more native ruby for the load / unload
- The kernel_module resource is now built into Chef 14.3 and later. When Chef 15.3 is released July 2019 this cookbook will be deprecated as all supported releases of Chef will include this resource.

## 1.1.1 (2018-04-18)

- Support RHEL/Fedora/Suse

## 1.1.0 (2018-04-18)

- This cookbook is now maintained by Chef in the chef-cookbooks org. Thank you Shopify for the initial work and transferring this cookbook here.
- Resolved failures on Chef 14
- Improved the not_if / only_if logic used to decide if the module should be loaded. Previously modules would often be detected as loaded when they were not
- Officially added Debian support in addition to Ubuntu
- Added initial support for non-Debian platforms
- Added chef_version metadata with 12.7 as the required version
- Added issues_url and source_url metadata
- Add a chefignore file to speed up transfers to/from the Chef server
- Removed the ChefSpec matchers since ChefSpec now autogenerates matchers
- Switched from Rake to Delivery Local Mode for testing
- Remove the specs to the default dir and use Berks
- Added InSpec tests for the test cookbook
