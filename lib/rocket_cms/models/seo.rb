module RocketCMS
  module Models
    module Seo
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Enableable
      include RocketCMS.orm_specific('Seo')

      included do
        RocketCMS.apply_patches self
        validates_attachment_content_type :og_image, content_type: %w(image/gif image/jpeg image/jpg image/png), if: :og_image?
      end
    end
  end

  def page_title
    title.blank? ? name : title
  end

  def get_og_title
    og_title.blank? ? name : og_title
  end
end

