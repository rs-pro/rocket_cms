module RocketCMS
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern
        unless RocketCMS.config.news_image_styles.nil?
          include ::Mongoid::Paperclip
        end
        included do
          field :time, type: Time
          index({enabled: 1, time: 1})
          unless RocketCMS.config.news_image_styles.nil?
            has_mongoid_attached_file :image, styles: RocketCMS.config.news_image_styles
            validates_attachment_content_type :image, content_type: %w(image/gif image/jpeg image/jpg image/png), if: :image?
          end
          field :name, type: String, localize: RocketCMS.config.localize
          field :excerpt, type: String, localize: RocketCMS.config.localize
          field :content, type: String, localize: RocketCMS.config.localize

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }
        end
      end
    end
  end
end

