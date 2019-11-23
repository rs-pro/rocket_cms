lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocket_cms/version'

Gem::Specification.new do |spec|
  spec.name          = 'rocket_cms_activerecord_light'
  spec.version       = RocketCMS::VERSION
  spec.authors       = ['glebtv']
  spec.email         = ['glebtv@gmail.com']
  spec.description   = %q{RocketCMS - ActiveRecord light metapackage}
  spec.summary       = %q{}
  spec.homepage      = 'https://gitlab.com/rocket-science/rocket_cms'
  spec.license       = 'MIT'

  spec.files         = %w(lib/rocket_cms_activerecord_light.rb)
  spec.executables   = []
  spec.test_files    = []
  spec.require_paths = ['lib']

  spec.add_dependency 'rocket_cms', RocketCMS::VERSION
  spec.add_dependency 'awesome_nested_set'
  spec.add_dependency 'friendly_id'
  spec.add_dependency "validates_lengths_from_database"

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
