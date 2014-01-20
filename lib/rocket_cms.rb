require 'rocket_cms/version'
require 'mongoid'

require 'glebtv-mongoid_nested_set'

require 'simple_form'
require 'glebtv-simple_captcha'

require 'yajl/json_gem'
require 'rs_russian'

require 'htmlentities'
require 'sanitize'

require 'devise'
require 'validates_email_format_of'

require 'glebtv-mongoid-paperclip'

require 'rails_admin'
require 'rails_admin/custom_show_in_app'

require 'rails_admin_nested_set'
require 'rails_admin_toggleable'
require 'glebtv-ckeditor'
require 'rails_admin_settings'

require 'mongoid-audit'
require 'mongoid_slug'

require 'simple-navigation'

require 'x-real-ip'

require 'sitemap_generator'
require 'kaminari'

require 'addressable/uri'

require 'filename_to_slug'
require 'smart_excerpt'

require 'history_tracker'

module RocketCMS
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :news_image_styles
    attr_accessor :news_per_page

    def initialize
      @news_image_styles = {
        main:  '400x200>',
        thumb: '200x100>',
      }

      @news_per_page = 10
    end
  end
end

require 'rocket_cms/engine'
require 'rocket_cms/railtie'
require 'rocket_cms/controller'

