# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocket_cms/version'

Gem::Specification.new do |spec|
  spec.name          = 'rocket_cms'
  spec.version       = RocketCms::VERSION
  spec.authors       = ['glebtv']
  spec.email         = ['glebtv@gmail.com']
  spec.description   = %q{RocketCMS}
  spec.summary       = %q{RocketCMS}
  spec.homepage      = 'https://github.com/rs-pro/rocket_cms'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  
  spec.add_dependency 'mongoid', '~> 4.0.0.beta1'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'glebtv-mongoid_nested_set'
  spec.add_dependency 'simple_form', '~> 3.0.0'
  spec.add_dependency 'glebtv-simple_captcha'
  # spec.add_dependency 'yajl-ruby'
  spec.add_dependency 'rs_russian'
  spec.add_dependency 'htmlentities'
  spec.add_dependency 'sanitize'
  spec.add_dependency 'coffee-rails'
  spec.add_dependency 'devise'
  spec.add_dependency 'turbolinks'
  spec.add_dependency 'validates_email_format_of'
  spec.add_dependency 'glebtv-mongoid-paperclip'
  spec.add_dependency 'rails_admin'
  spec.add_dependency 'rails_admin_nested_set'
  spec.add_dependency 'rails_admin_toggleable'
  spec.add_dependency 'glebtv-ckeditor'
  spec.add_dependency 'rails_admin_settings'
  spec.add_dependency 'geocoder'
  spec.add_dependency 'mongoid-audit'
  spec.add_dependency 'mongoid_slug'
  spec.add_dependency 'simple-navigation'
  spec.add_dependency 'unicorn'
  spec.add_dependency 'x-real-ip'
  spec.add_dependency 'sitemap_generator'
  spec.add_dependency 'kaminari'
  spec.add_dependency 'addressable'
  spec.add_dependency 'ruby-progressbar'
end
