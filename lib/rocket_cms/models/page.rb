module RocketCMS
  module Models
    module Page
      extend ActiveSupport::Concern

      include RocketCMS::Model
      include Enableable
      include Seoable
      include ManualSlug
      if RocketCMS.configuration.search_enabled
        include RocketCMS::ElasticSearch
      end
        
      included do
        field :regexp, type: String
        field :redirect, type: String
        field :content, type: String
        field :fullpath, type: String

        scope :sorted, -> { order_by([:lft, :asc]) }
        scope :menu, ->(menu_id) { enabled.sorted.where(menu_ids: menu_id) }

        has_and_belongs_to_many :menus, inverse_of: :pages

        acts_as_nested_set
        
        manual_slug :name

        before_validation do
          self.fullpath = "/pages/#{slug}" if self.fullpath.blank?
        end
        validates_uniqueness_of :fullpath

        validates_presence_of :name
      end

      def get_fullpath
        redirect.blank? ? fullpath : redirect
      end

      def has_content?
        @content_used.nil? && !content.blank?
      end

      def page_content
        if @content_used.nil?
          @content_used = true
          if content.nil?
            ''
          else
            content.gsub(/\{\{(.*?)\}\}/) do
              Settings.get($1).val
            end
          end
        else
          ''
        end
      end

      def is_current?(url)
        if fullpath == '/'
          url == '/'
        else
          url.match(clean_regexp)
        end
      end
      
      def clean_regexp
        if regexp.blank?
          /^#{Regexp.escape(fullpath)}$/
        else
          begin
            /#{regexp}/
          rescue
            # not a valid regexp - treat as literal search string
            /#{Regexp.escape(regexp)}/
          end
        end
      end
      
      def nav_options
        {highlights_on: clean_regexp}
      end
    end
  end
end
