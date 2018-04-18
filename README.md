# kernel_module Cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/kernel_module.svg?branch=master)](http://travis-ci.org/chef-cookbooks/kernel_module) [![Cookbook Version](https://img.shields.io/cookbook/v/kernel_module.svg)](https://supermarket.chef.io/cookbooks/kernel_module)

This cookbook will aid in adding/removing kernel modules from a running system, and ensure they're loaded at system boot.

## Requirements

### Platforms

- Debian/Ubuntu
- Redhat and derivatives
- Fedora
- Amazon Linux
- openSUSE

### Chef

- Chef 12.7+

### Cookbooks

- none

## Recipes

### default

This recipe expects `node[:kernel_modules]` to be of the form:

```ruby
{
  raid10: :install,
  raid456: :uninstall,
  ntfs: :blacklist
}
```

and performs the actions specified on the modules listed, so you can specify modules to load/unload entirely from a role-file.

## Attributes

### General

- `['kernel_modules']` - Hash of modules to perform actions on using the default recipe.

## Resources

### `kernel_module`

This resource allows you to manage kernel modules.

#### Actions

- `:install`: loads the module immediately, adds an entry to `/etc/modprobe.d` to ensure it loads on boot, and updates the initramfs.
- `:uninstall`: unloads the module immediately, removes the configuration entry, and updates the initrams.
- `:blacklist`: unloads the module immediately, and adds a configuration file to blacklist the module.
- `:load`: loads the module immediately.
- `:unload`: unloads the module immediately.

#### Examples

Permanently load the `zfs` module:

```ruby
kernel_module 'zfs'
```

Unload just the `raid10` module:

```ruby
kernel_module 'raid10' do
  action :unload
end
```

## Maintainers

This cookbook is maintained by Chef's Community Cookbook Engineering team. Our goal is to improve cookbook quality and to aid the community in contributing to cookbooks. To learn more about our team, process, and design goals see our [team documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/COOKBOOK_TEAM.MD). To learn more about contributing to cookbooks like this see our [contributing documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/CONTRIBUTING.MD), or if you have general questions about this cookbook come chat with us in #cookbok-engineering on the [Chef Community Slack](http://community-slack.chef.io/)

## License

**Copyright:** 2018, Chef Software, Inc.
**Copyright:** 2016-2018, Shopify, Inc.