module RocketCMS
  module Models
    module News
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Seoable
      include Enableable
      include RocketCMS.orm_specific('News')
      include ManualSlug

      if RocketCMS.configuration.search_enabled
        include RocketCMS::ElasticSearch
      end

      included do
        validates_presence_of :name, :content
        before_validation do
          self.time = Time.now if self.time.blank?
        end
        scope :recent, ->(count = 5) { enabled.after_now.by_date.limit(count) }
        unless RocketCMS.configuration.news_per_page.nil?
          paginates_per RocketCMS.configuration.news_per_page
        end
        smart_excerpt :excerpt, :content, RocketCMS.configuration.news_excerpt
        manual_slug :report_slug

        RocketCMS.apply_patches self
      end

      def report_slug
        if time.blank?
          name
        elsif name.blank?
          time.strftime('%Y-%m-%d')
        else
          time.strftime('%Y-%m-%d') + '-' + name[0..20]
        end
      end
      def html5_date
        time.strftime('%Y-%m-%d')
      end
      def format_date
        time.strftime('%d.%m.%Y')
      end
    end
  end
end

