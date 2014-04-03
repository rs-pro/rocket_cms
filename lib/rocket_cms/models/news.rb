module RocketCMS
  module Models
    module News
      extend ActiveSupport::Concern

      included do
        include RocketCMS::Model
        include Seoable
        include Enableable

        field :time, type: Time
        index({enabled: 1, time: 1})
        scope :after_now, -> { where(:time.lt => Time.now) }

        field :excerpt, type: String
        field :content, type: String

        unless RocketCMS.configuration.news_image_styles.nil?
          include Mongoid::Paperclip
          has_mongoid_attached_file :image, styles: RocketCMS.configuration.news_image_styles
          validates_attachment_content_type :image, :content_type => ['image/gif', 'image/jpeg', 'image/jpg', 'image/png'], if: :image?
        end

        validates_presence_of :name, :content

        before_validation do
          self.time = Time.now if self.time.blank?
        end

        include ManualSlug
        manual_slug :report_slug

        scope :by_date, -> { desc(:time) }
        scope :recent, ->(count = 5) { enabled.after_now.by_date.limit(count) }
        unless RocketCMS.configuration.news_per_page.nil?
          paginates_per RocketCMS.configuration.news_per_page
        end

        smart_excerpt :excerpt, :content, RocketCMS.configuration.news_excerpt

        if RocketCMS.configuration.search_enabled
          include RocketCMS::ElasticSearch
        end
        RocketCMS.apply_patches self

        rails_admin do
          navigation_label I18n.t('rs.cms')

          field :enabled, :toggle
          field :time
          field :name
          unless RocketCMS.configuration.news_image_styles.nil?
            field :image
          end
          field :excerpt
          RocketCMS.apply_patches self

          edit do
            field :content, :ck_editor
            RocketCMS.apply_patches self
            group :seo, &Seoable.seo_config
          end

          RocketCMS.only_patches self, [:show, :list, :export]
        end
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
