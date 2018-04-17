source 'https://rubygems.org'

ruby '~> 2.3.0'

group :lint do
  gem 'foodcritic', '~> 13.0'
  gem 'rubocop', '~> 0.55'
end

group :unit do
  gem 'berkshelf',  '~> 4.0'
  gem 'chefspec',   '~> 4.4'
  gem 'chef',       '~> 12.5.0'
end

group :kitchen do
  gem 'test-kitchen', '~> 1.4'
  gem 'kitchen-vagrant', '~> 0.19'
end

group :release do
  gem 'rake'
end
