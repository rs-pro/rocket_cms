# RocketCMS

## RocketScience's Ruby On Rails app template / starter kit

What's in the box when you generate a new app:

- Rails 5.1
- ActiveRecord + PostgreSQL or Mongoid 6
- Elasticsearch (optional)
- RailsAdmin
- Webpack via webpack-rails with fully customizeable webpack.config.js
- JS packages via package.json
- Capistrano deploy (including puma and webpack)
- Puma in production and in development
- Basic windows support (development env only)
- Basic CMS models and controllers (Pages + SEO, News, Contact form with mailer, menu)
- Basic SEO optimization functionality, including editing meta and OG tags
- Optimized admin interface, including editing pages and menu
- Menu via SimpleNavigation
- Ckeditor with image upload support
- L10n and i18n support


## Installation (existing app)

Add this line to your application's Gemfile:

    gem 'rocket_cms_mongoid'

or:

    gem 'rocket_cms_activerecord'

Or, if you don't need CKeditor, GeoCoder, mongoid-audit\paper_trail:

    gem 'rocket_cms_mongoid_light'
    gem 'rocket_cms_activerecord_light'

*Only PostgreSQL is tested or supported for AR. Others will probably work, but untested.*

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rocket_cms

For activerecord, generate migrations and run them

    rails g rails_admin_settings:migration
    rails g rocket_cms:migration
    rake db:migrate


### Generating a new app

Make sure you have rails 5.1 installed

    rails -v

If not, uninstall rails and install again

    gem uninstall rails
    gem install rocket_cms

Then, for mongoid:

    rails new my_app -T -O -m https://raw.githubusercontent.com/rs-pro/rocket_cms/master/template.rb --skip-spring

for ActiveRecord:

    rails new my_app -T --database=postgresql -m https://raw.githubusercontent.com/rs-pro/rocket_cms/master/template.rb --skip-spring

generator creates a new RVM gemset, so after cd'ing to app dir, you should run `bundle install` again if you use rvm.

### Localization

All models included in the gem support localization via either [hstore_translate](https://github.com/Leadformance/hstore_translate) or built-in Mongoid localize: true option.

You can get a nice admin UI for editing locales by adding [rails_admin_hstore_translate](https://github.com/glebtv/rails_admin_hstore_translate) or [rails_admin_mongoid_localize_field](https://github.com/sudosu/rails_admin_mongoid_localize_field)

Add to: ```app/models/page.rb```

```ruby
class Page < ActiveRecord::Base
  include RocketCMS::Models::Page
  RocketCMS.apply_patches self
  rails_admin &RocketCMS.page_config

  def regexp_prefix
    "(?:\/ru|\/en)?"
  end
end
```

Wrap your routes with locale scope:

```ruby
scope "(:locale)", locale: /en|ru/ do
  get 'contacts' => 'contacts#new', as: :contacts
  post 'contacts' => 'contacts#create', as: :create_contacts
end
```

Add to application_controller.rb:

```ruby
class ApplicationController < ActionController::Base
  include RocketCMS::Controller
  include RsLocalizeable
end
```

Enable localization in RocketCMS:

```ruby
RocketCMS.configure do |rc|
  rc.news_image_styles = {small: '107x126#'}
  rc.contacts_captcha = true
  rc.contacts_message_required = true
  ...
  rc.localize = true
end
```

Add ```rails_admin_hstore_translate``` or ```hstore_translate``` gem if using PostgreSQL:

```ruby
gem 'rails_admin_hstore_translate'
```

or

```ruby
gem 'hstore_translate'
```

or

```ruby
gem 'jsonb_translate' # requires postgresql 9.4
```

Add ```rails_admin_mongoid_localize_field``` gem if using MongoDB:

```ruby
gem 'rails_admin_mongoid_localize_field'
```

### Capistrano generator

    rails g rocket_cms:capify domain_name
    # (path /data/:user/app/ - rocket science default)

designed to be used together with our ansible app setup script.

### Alternative capistrano task (can be used with non-configured app)

   bundle exec rocket_cms capify PmiGames pg.pmi.ru

### Documentation

It's basically Rails Admin + some of our common models and controllers, capistrano config, etc.

See their documentation for more info

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
