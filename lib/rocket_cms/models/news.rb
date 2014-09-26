module RocketCMS
  module Models
    module News
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Seoable

      include RocketCMS.orm_specific('News')

      if RocketCMS.configuration.search_enabled
        include RocketCMS::ElasticSearch
      end
      unless RocketCMS.configuration.news_image_styles.nil?
        include ::Mongoid::Paperclip
      end
      included do
        scope :after_now, -> { where(:time.lt => Time.now) }
        validates_presence_of :name, :content
        before_validation do
          self.time = Time.now if self.time.blank?
        end
        scope :by_date, -> { desc(:time) }
        scope :recent, ->(count = 5) { enabled.after_now.by_date.limit(count) }
        unless RocketCMS.configuration.news_per_page.nil?
          paginates_per RocketCMS.configuration.news_per_page
        end
        smart_excerpt :excerpt, :content, RocketCMS.configuration.news_excerpt
        RocketCMS.apply_patches self
      end

      def report_slug
        time.strftime('%Y-%m-%d') + '-' + name[0..20]
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

