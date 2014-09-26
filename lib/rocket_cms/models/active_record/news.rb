module RocketCMS
  module Models
    module ActiveRecord
      module News
        extend ActiveSupport::Concern
        included do
          extend FriendlyId

          unless RocketCMS.configuration.news_image_styles.nil?
            has_attached_file :image, styles: RocketCMS.configuration.news_image_styles
            validates_attachment_content_type :image, :content_type => ['image/gif', 'image/jpeg', 'image/jpg', 'image/png'], if: :image?
          end
          friendly_id :report_slug, use: [:slugged, :finders]
          has_paper_trail

          validates_lengths_from_database, only: [:name, :title, :content, :excerpt, :h1, :keywords, :robots, :og_title]
        end
      end
    end
  end
end

