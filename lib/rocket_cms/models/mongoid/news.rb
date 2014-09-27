module RocketCMS
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern
        unless RocketCMS.configuration.news_image_styles.nil?
          include ::Mongoid::Paperclip
        end
        include ManualSlug
        included do
          field :time, type: Time
          index({enabled: 1, time: 1})
          unless RocketCMS.configuration.news_image_styles.nil?
            has_mongoid_attached_file :image, styles: RocketCMS.configuration.news_image_styles
            validates_attachment_content_type :image, :content_type => ['image/gif', 'image/jpeg', 'image/jpg', 'image/png'], if: :image?
          end

          field :excerpt, type: String, localize: RocketCMS.configuration.localize
          field :content, type: String, localize: RocketCMS.configuration.localize
          manual_slug :report_slug

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }
        end
      end
    end
  end
end

