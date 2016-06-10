source 'https://rubygems.org'

group :rake do
  gem 'rake'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'

  puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '3.3'
  gem 'puppet', "~> #{puppetversion}"

end
