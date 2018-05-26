module RocketCMS
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :news_image_styles
    attr_accessor :news_per_page
    attr_accessor :news_excerpt
    attr_accessor :news_content_required

    attr_accessor :error_layout
    attr_accessor :menu_max_depth

    attr_accessor :search_enabled
    attr_accessor :search_per_page
    attr_accessor :search_models

    attr_accessor :contacts_captcha
    attr_accessor :contacts_fields
    attr_accessor :contacts_message_required

    attr_accessor :seo_active_by_default

    attr_accessor :separate_seo_table

    attr_accessor :localize

    def initialize
      @news_image_styles = {
        main:  '400x200>',
        thumb: '200x100>',
      }
      @news_per_page = 10
      @news_excerpt = 12
      @news_content_required = true

      @error_layout = 'application'
      @menu_max_depth = 2

      @search_enabled = false
      @search_per_page = 10
      @search_models = []

      @contacts_captcha = false
      @contacts_fields = {}
      @contacts_message_required = true

      @localize = false

      @separate_seo_table = false
      @seo_active_by_default = true
    end

    def search_enabled=(val)
      @search_enabled = val
      if @search_enabled
        @search_models << 'Page'
        @search_models << 'News'
      end
    end
  end
end
