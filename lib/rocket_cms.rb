require 'rocket_cms/version'

require 'mongoid'
# require 'yajl/json_gem'
require 'devise'

require 'simple_form'
require 'glebtv-simple_captcha'

require 'validates_email_format_of'

require 'htmlentities'
require 'sanitize'
require 'smart_excerpt'

# uploads
require 'glebtv-mongoid-paperclip'
require 'filename_to_slug'

# admin
require 'rails_admin'
require 'rails_admin/custom_show_in_app'

require 'rs_russian'

require 'glebtv-mongoid_nested_set'
require 'rails_admin_nested_set'
require 'rails_admin_toggleable'
require 'glebtv-ckeditor'
require 'rails_admin_settings'
require 'mongoid-audit'
require 'history_tracker' # audit model

require 'mongoid_slug'

require 'x-real-ip'
require 'sitemap_generator'
require 'kaminari'
require 'addressable/uri'
require 'turbolinks'
require 'simple-navigation'

require 'rocket_cms/configuration'
require 'rocket_cms/patch'
require 'rocket_cms/page_config'
require 'rocket_cms/elastic_search' # FTS, optional
require 'rocket_cms/model'
require 'rocket_cms/engine'
require 'rocket_cms/railtie'
require 'rocket_cms/controller'

require 'rocket_cms/models/news'
require 'rocket_cms/models/menu'
require 'rocket_cms/models/page'
require 'rocket_cms/models/contact_message'
