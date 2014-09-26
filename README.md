# RocketCMS

rails_admin + mongoid + elasticsearch CMS

Very opinionated and tuned for our needs.

Sorry, no documentation or examples are availiable yet. Stay tuned

**Before 1.0 API and class names should be considered unstable and can change at
any time!**

## Installation

Add this line to your application's Gemfile:

    gem 'rocket_cms_mongoid'

or:

    gem 'rocket_cms_activerecord'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rocket_cms

For activerecord, generate migrations and run them

    rails g rails_admin_settings:migration
    rails g rocket_cms:migration
    rake db:migrate

## Usage

### Using app generator

Make sure you have rails 4.1 installed

    rails -v

If not, uninstall rails and install again

    gem uninstall rails
    gem install rocket_cms
    
Then, for mongoid:

    rails new my_app -T -O -m https://raw.github.com/rs-pro/rocket_cms/master/template.rb

for ActiveRecord:

    rails new my_app -T --database=postgresql -m https://raw.github.com/rs-pro/rocket_cms/master/template.rb

generator creates a new RVM gemset, so after cd'ing to app dir, you should run `bundle install` again if you use rvm.

### Documentation

It's basically Mongoid + Rails Admin + some of our common models and controllers, capistrano config, etc.

See their documentation for more info

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

