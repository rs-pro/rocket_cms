unless defined?(RocketCMS) && RocketCMS.respond_to?(:orm) && [:active_record, :mongoid].include?(RocketCMS.orm)
  puts "please use rocket_cms_mongoid or rocket_cms_activerecord and not rocket_cms directly"
  exit 1
end

require 'rocket_cms/version'
require 'validates_email_format_of'
require 'smart_excerpt'
require 'filename_to_slug'

require 'kaminari'
require 'addressable/uri'
require 'turbolinks'

require 'rocket_cms/seo_helpers'
require 'rocket_cms/configuration'
require 'rocket_cms/patch'
require 'rocket_cms/admin'
require 'rocket_cms/search'
require 'rocket_cms/model'
if defined?(RailsAdmin)
  require 'rocket_cms/rails_admin_menu'
end
require 'rocket_cms/engine'
require 'rocket_cms/controller'

module RocketCMS
  class << self
    def mongoid?
      RocketCMS.orm == :mongoid
    end
    def full?
      !RocketCMS.light?
    end
    def active_record?
      RocketCMS.orm == :active_record
    end
    def model_namespace
      "RocketCMS::Models::#{RocketCMS.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end

    def url_helper
      @@url_helper ||= RocketCMS::UrlHelper.new
    end

    def custom_app_url(object)
      url_helper.polymorphic_url(object, routing_type: :path)
    end

    def app_url(object)
      if object.class.name == 'Page'
        if object.fullpath.blank?
          url_helper.page_path(object)
        else
          object.fullpath
        end
      else
        RocketCMS.custom_app_url(object)
      end
    end
  end

  autoload :Menu, 'rocket_cms/menu'
  autoload :Migration, 'rocket_cms/migration'
  autoload :UrlHelper, 'rocket_cms/url_helper'

  module Models
    autoload :Seo,  'rocket_cms/models/seo'
    autoload :Menu, 'rocket_cms/models/menu'
    autoload :Page, 'rocket_cms/models/page'
    autoload :News, 'rocket_cms/models/news'
    autoload :ContactMessage, 'rocket_cms/models/contact_message'

    module Mongoid
      autoload :Seo,  'rocket_cms/models/mongoid/seo'
      autoload :Menu, 'rocket_cms/models/mongoid/menu'
      autoload :Page, 'rocket_cms/models/mongoid/page'
      autoload :News, 'rocket_cms/models/mongoid/news'
      autoload :ContactMessage, 'rocket_cms/models/mongoid/contact_message'
    end

    module ActiveRecord
      autoload :Seo,  'rocket_cms/models/active_record/seo'
      autoload :Menu, 'rocket_cms/models/active_record/menu'
      autoload :Page, 'rocket_cms/models/active_record/page'
      autoload :News, 'rocket_cms/models/active_record/news'
      autoload :ContactMessage, 'rocket_cms/models/active_record/contact_message'
    end
  end

  module Controllers
    autoload :Contacts, 'rocket_cms/controllers/contacts'
    autoload :News, 'rocket_cms/controllers/news'
    autoload :Pages, 'rocket_cms/controllers/pages'
    autoload :Search, 'rocket_cms/controllers/search'
  end
end

require 'rails_admin_nested_set/helper'

module RailsAdminNestedSet::Helper
  def extra_fields(node)
    if node.class.name == 'Page'
      ret = RocketCMS::Menu.build_toggles(self, node.class, node, 'xs', '')
      ('<div style="white-space: normal; display: inline-block; margin-left: 10px;">' + ret.join(' ') + '</div>').html_safe
    else
      "".html_safe
    end
  end
end

require 'manual_slug'
