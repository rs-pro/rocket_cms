module RocketCMS
  module Models
    module Mongoid
      module Seo
        extend ActiveSupport::Concern
        if RocketCMS.shrine?
          include ImageUploader::Attachment(:og_image)
        elsif RocketCMS.paperclip?
          include ::Mongoid::Paperclip
        end
        included do
          field :name, type: String, localize: RocketCMS.config.localize
          field :h1, type: String, localize: RocketCMS.config.localize

          field :title, type: String, localize: RocketCMS.config.localize
          field :keywords, type: String, localize: RocketCMS.config.localize
          field :description, type: String, localize: RocketCMS.config.localize
          field :robots, type: String, localize: RocketCMS.config.localize

          field :og_title, type: String, localize: RocketCMS.config.localize

          if RocketCMS.paperclip?
            has_mongoid_attached_file :og_image, styles: {thumb: "800x600>"}
          end
        end
      end
    end
  end
end

