module RocketCMS
  module Models
    module ActiveRecord
      module News
        extend ActiveSupport::Concern
        included do
          unless RocketCMS.config.news_image_styles.nil?
            has_attached_file :image, styles: RocketCMS.config.news_image_styles
            validates_attachment_content_type :image, content_type: %w(image/gif image/jpeg image/jpg image/png), if: :image?
          end

          has_paper_trail

          validates_lengths_from_database only: [:name, :title, :content, :excerpt, :h1, :keywords, :robots, :og_title]

          scope :after_now, -> { where("time < ?", Time.now) }
          scope :by_date, -> { order(time: :desc) }

          if RocketCMS.config.localize
            translates :name, :excerpt, :content
          end
        end
      end
    end
  end
end

