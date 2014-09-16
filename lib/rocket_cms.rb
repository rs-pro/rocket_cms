require 'rocket_cms/version'

require 'mongoid'
# require 'yajl/json_gem'
require 'devise'

require 'simple_form'
require 'glebtv-simple_captcha'

require 'validates_email_format_of'

require 'smart_excerpt'

# uploads
require 'glebtv-mongoid-paperclip'
require 'filename_to_slug'

require 'rails_admin'
# require 'rs_russian'

require 'glebtv-mongoid_nested_set'
require 'rails_admin_nested_set'
require 'rails_admin_toggleable'
require 'glebtv-ckeditor'
require 'rails_admin_settings'
require 'mongoid-audit'

require 'mongoid_slug'

require 'sitemap_generator'
require 'kaminari'
require 'addressable/uri'
require 'turbolinks'
require 'simple-navigation'

require 'rocket_cms/configuration'
require 'rocket_cms/patch'
require 'rocket_cms/admin'
require 'rocket_cms/elastic_search' # FTS, optional
require 'rocket_cms/model'
require 'rocket_cms/rails_admin_menu'
require 'rocket_cms/engine'
require 'rocket_cms/controller'

module RocketCMS
  module Models
    autoload :Menu, 'rocket_cms/models/menu'
    autoload :Page, 'rocket_cms/models/page'
    autoload :News, 'rocket_cms/models/news'
    autoload :ContactMessage, 'rocket_cms/models/contact_message'
  end

  module Controllers
    autoload :Contacts, 'rocket_cms/controllers/contacts'
    autoload :News, 'rocket_cms/controllers/news'
    autoload :Pages, 'rocket_cms/controllers/pages'
    autoload :Search, 'rocket_cms/controllers/search'
  end
end