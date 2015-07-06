module RocketCMS
  module Models
    module ActiveRecord
      module Seo
        extend ActiveSupport::Concern
        included do
          has_attached_file :og_image, styles: {thumb: "800x600>"}
          if RocketCMS.config.localize
            translates :h1, :title, :keywords, :description, :og_title
          end
        end
      end
    end
  end
end


