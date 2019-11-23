module RocketCMS
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern
        if !RocketCMS.config.news_image_styles.nil?
          if RocketCMS.shrine?
            include ImageUploader::Attachment(:image)
          elsif RocketCMS.paperclip?
            include ::Mongoid::Paperclip
          end
        end
        included do
          field :time, type: Time
          index({enabled: 1, time: 1})
          if RocketCMS.paperclip? && RocketCMS.config.news_image_styles.nil?
            has_mongoid_attached_file :image, styles: RocketCMS.config.news_image_styles
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

