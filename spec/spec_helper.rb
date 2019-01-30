require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = true               # Use color in STDOUT
  config.formatter = :documentation # Use the specified formatter
  config.log_level = :error         # Avoid deprecation notice SPAM
end

class Chef
  class ResourceBuilder
    def emit_cloned_resource_warning
    end
  end
end
