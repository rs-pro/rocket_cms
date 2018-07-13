# RocketCMS

Master repository has moved to gitlab, all new code will be there:

https://gitlab.com/rocket-science/rocket_cms

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

    rails new my_app -T -O -m https://gitlab.com/rocket-science/rocket_cms/raw/master/template.rb --skip-spring

for ActiveRecord:

    rails new my_app -T --database=postgresql -m https://gitlab.com/rocket-science/rocket_cms/raw/master/template.rb --skip-spring

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

Add ```rails_admin_translate```:

```ruby
gem 'rails_admin_translate'
```

And, for ActiveRecord a translation gem you wish to use (mongoid should work with built-in localization):

```ruby
gem 'json_translate'
```

or

```ruby
gem 'globalize'
```

Create your models, or, if adding localization to existing app, migrate your locale data.

Example for globalize (needs adjustment):

```
class AddTranslations < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        I18n.with_locale(:ru) do
          Page.create_translation_table!({
            name: :string,
            content: :text,
          }, {
            migrate_data: true,
            #remove_source_columns: true,
          })

          News.create_translation_table!({
            name: :string,
            excerpt: :string,
            content: :text,
          }, {
            migrate_data: true,
            #remove_source_columns: true,
          })

          Seos.create_translation_table!({
            h1: :string,
            title: :string,
            keywords: :text,
            description: :text,
            og_title: :string,
          }, {
            migrate_data: true,
            #remove_source_columns: true,
          })
        end
      end

      dir.down do
        I18n.with_locale(:ru) do
          [Page, News, Menu, Seo].drop_translation_table!(migrate_data: true)
        end
      end
    end
```

Example for json_translate (needs adjustment):

```
class AddLocales < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :name_translations, :jsonb, default: {}
    add_column :pages, :content_translations, :jsonb, default: {}

    add_column :news, :name_translations, :jsonb, default: {}
    add_column :news, :excerpt_translations, :jsonb, default: {}
    add_column :news, :content_translations, :jsonb, default: {}

    add_column :menus, :name_translations, :jsonb, default: {}
    add_column :seos, :h1_translations, :jsonb, default: {}
    add_column :seos, :title_translations, :jsonb, default: {}
    add_column :seos, :keywords_translations, :jsonb, default: {}
    add_column :seos, :description_translations, :jsonb, default: {}
    add_column :seos, :og_title_translations, :jsonb, default: {}

    reversible do |dir|
      dir.up do
        execute "UPDATE pages SET name_translations = json_build_object('ru', \"name\")"
        execute "UPDATE pages SET content_translations = json_build_object('ru', \"content\")"
        execute "UPDATE news SET name_translations = json_build_object('ru', \"name\")"
        execute "UPDATE news SET content_translations = json_build_object('ru', \"content\")"
        # etc
      end
      dir.down do
        raise 'irreversible'
      end
    end
  end
end
```
### BACKUP YOUR DB

then drop old fields, or you will have errors with required fields being null

```
class DropLocale < ActiveRecord::Migration[5.2]
  def change
    remove_column :pages, :name
    remove_column :pages, :content

    remove_column :news, :name
    remove_column :news, :excerpt
    remove_column :news, :content

    remove_column :menus, :name
    remove_column :seos, :h1
    remove_column :seos, :title
    remove_column :seos, :keywords
    remove_column :seos, :description
    remove_column :seos, :og_title
  end
end
```

### Capistrano generator

    rails g rocket_cms:capify domain_name
    # (path /data/:user/app/ - rocket science default)

designed to be used together with our ansible app setup script.

### Alternative capistrano task (can be used with non-configured app \ without db)

    bundle exec rocket_cms_capify Games games.ru

### Documentation

It's basically Rails Admin + some of our common models and controllers, capistrano config, etc.

See their documentation for more info

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
