source 'https://rubygems.org'

group :rake do
  gem 'rake'
  gem 'puppet-lint'
  gem 'rspec'
  gem 'rspec-puppet'

  puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '2.7'
  gem 'puppet', "~> #{puppetversion}"
  gem 'puppetlabs_spec_helper'
  gem 'hiera'
  gem 'hiera-puppet-helper', :github => 'vStone/hiera-puppet-helper'

  if puppetversion =~ /^2/
    gem 'hiera-puppet'
  end

end
