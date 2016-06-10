source 'https://rubygems.org'

group :rake do
  gem 'rake'
  gem 'puppet-lint'
  gem 'rspec'
  gem 'rspec-puppet'

  puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '3.3'
  gem 'puppet', "~> #{puppetversion}"
  gem 'puppetlabs_spec_helper'

  if puppetversion =~ /^2/
    gem 'hiera-puppet'
  end

end
