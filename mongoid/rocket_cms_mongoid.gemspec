lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rocket_cms/version'

Gem::Specification.new do |spec|
  spec.name          = 'rocket_cms_mongoid'
  spec.version       = RocketCMS::VERSION
  spec.authors       = ['glebtv']
  spec.email         = ['glebtv@gmail.com']
  spec.description   = %q{RocketCMS - Mongoid metapackage}
  spec.summary       = %q{}
  spec.homepage      = 'https://gitlab.com/rocket-science/rocket_cms'
  spec.license       = 'MIT'

  spec.files         = %w(lib/rocket_cms_mongoid.rb)
  spec.executables   = []
  spec.test_files    = []
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'mongoid', ['>= 6.0.0', '< 8.0']
  spec.add_dependency 'rocket_cms', RocketCMS::VERSION

  spec.add_dependency 'glebtv-mongoid_nested_set'
  spec.add_dependency 'mongoid-paperclip'
  spec.add_dependency 'mongoid-audit'
  spec.add_dependency 'mongoid-slug'
  spec.add_dependency 'glebtv-ckeditor'
  spec.add_dependency 'geocoder'

  spec.add_dependency 'glebtv-simple_captcha'
  spec.add_dependency 'simple_form'
  spec.add_dependency 'devise'
  spec.add_dependency 'rails_admin'
  spec.add_dependency 'rails_admin_nested_set'
  spec.add_dependency 'rails_admin_toggleable'
  spec.add_dependency 'rails_admin_settings'
  spec.add_dependency 'rocket_navigation'
  spec.add_dependency 'sitemap_generator'
  spec.add_dependency 'kaminari-mongoid'
end
