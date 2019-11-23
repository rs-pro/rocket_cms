module RocketCMS
  module Models
    module News
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Seoable
      include Enableable
      include RocketCMS.orm_specific('News')
      include ManualSlug

      if RocketCMS.config.search_enabled
        include RocketCMS::Search
      end

      included do

        if RocketCMS.paperclip? && !RocketCMS.config.news_image_styles.nil?
          validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
        end

        validates_presence_of :name
        if RocketCMS.config.news_content_required
          validates_presence_of :content
        end
        before_validation do
          self.time = Time.now if self.time.blank?
        end
        scope :recent, ->(count = 5) { enabled.after_now.by_date.limit(count) }
        unless RocketCMS.config.news_per_page.nil?
          paginates_per RocketCMS.config.news_per_page
        end
        smart_excerpt :excerpt, :content, RocketCMS.config.news_excerpt
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
