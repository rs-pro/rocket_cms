module RocketCMS
  module Models
    module ActiveRecord
      module Seo
        extend ActiveSupport::Concern
        included do
          if RocketCMS.shrine?
            include OgImageUploader.attachment(:og_image)
          elsif RocketCMS.paperclip?
            has_attached_file :og_image, styles: {thumb: "800x600>"}
          end
          if RocketCMS.config.localize
            translates :h1, :title, :keywords, :description, :og_title
          end
        end
      end
    end
  end
end


