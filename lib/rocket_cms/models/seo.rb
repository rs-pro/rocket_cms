module RocketCMS
  module Models
    module Seo
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Enableable
      include RocketCMS.orm_specific('Seo')
      include RocketCMS::SeoHelpers

      included do
        RocketCMS.apply_patches self
        if RocketCMS.paperclip?
          validates_attachment_content_type :og_image, content_type: /\Aimage\/.*\Z/, if: :og_image?
        end
      end
    end
  end
end

