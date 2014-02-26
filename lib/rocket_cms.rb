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
require 'ruby-progressbar'

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
    attr_accessor :news_excerpt

    attr_accessor :error_layout
    attr_accessor :menu_max_depth

    attr_accessor :search_enabled
    attr_accessor :search_per_page
    attr_accessor :search_models

    attr_accessor :contacts_captcha
    attr_accessor :contacts_fields
    attr_accessor :contacts_message_required

    # attr_accessor :album_image_styles

    def initialize
      @news_image_styles = {
        main:  '400x200>',
        thumb: '200x100>',
      }
      @news_per_page = 10
      @news_excerpt = 12

      @error_layout = 'application'
      @menu_max_depth = 2

      @search_enabled = false
      @search_per_page = 10
      @search_models = []

      #@album_image_styles = {
      #  thumb: '182x155#',
      #  main: '800x600>'
      #}

      @contacts_captcha = false
      @contacts_fields = {}
      @contacts_message_required = true
    end

    def search_enabled=(val)
      @search_enabled = val
      if @search_enabled
        @search_models << 'Page'
        @search_models << 'News'
      end
    end
  end

  def self.page_config
    Proc.new {
      navigation_label I18n.t('rs.cms')
      list do
        field :enabled,  :toggle
        field :menus
        field :name
        field :fullpath do
          pretty_value do
            bindings[:view].content_tag(:a, bindings[:object].fullpath, href: bindings[:object].fullpath)
          end
        end
        field :redirect
        field :slug
      end
      edit do
        field :name
        field :content, :ckeditor
        group :menu do
          label I18n.t('rs.menu')
          field :menus
          field :fullpath, :string do
            help I18n.t('rs.with_final_slash')
          end
          field :regexp, :string do
            help I18n.t('rs.page_url_regex')
          end
          field :redirect, :string do
            help I18n.t('rs.final_in_menu')
          end
        end
        group :seo, &Seoable.seo_config
      end
      nested_set({
        max_depth: RocketCMS.configuration.menu_max_depth
      })
    }
  end
end

require 'rocket_cms/elastic_search'
require 'rocket_cms/model'
require 'rocket_cms/engine'
require 'rocket_cms/railtie'
require 'rocket_cms/controller'
require 'no_extra_ul'