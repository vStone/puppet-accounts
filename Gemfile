source 'https://rubygems.org'

group :rake do
  gem 'rake'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'
  gem 'metadata-json-lint'

  puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '4'
  gem 'puppet', "~> #{puppetversion}"

  # https://tickets.puppetlabs.com/browse/PUP-3796
  if puppetversion =~ /^3(?:\.?.*)?$/
    gem 'safe_yaml', '~> 1.0.4'
  end

end
