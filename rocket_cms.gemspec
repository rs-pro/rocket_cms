lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocket_cms/version'

Gem::Specification.new do |spec|
  spec.name          = 'rocket_cms'
  spec.version       = RocketCMS::VERSION
  spec.authors       = ['glebtv']
  spec.email         = ['glebtv@gmail.com']
  spec.description   = %q{RocketCMS}
  spec.summary       = %q{Please DO NOT use this gem directly, use rocket_cms_mongoid or rocket_cms_activerecord instead!}
  spec.homepage      = 'https://github.com/rs-pro/rocket_cms'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/).reject {|f| f.start_with?('mongoid') || f.start_with?('activerecord') }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'rails', '>= 4.1.0', '< 5.1'

  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'coffee-rails'
  spec.add_dependency 'turbolinks'
  spec.add_dependency 'validates_email_format_of'
  spec.add_dependency 'addressable'
  spec.add_dependency 'stringex'
  spec.add_dependency 'thor'
  spec.add_dependency 'smart_excerpt'

end
