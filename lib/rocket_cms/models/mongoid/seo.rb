module RocketCMS
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern
        include ::Mongoid::Paperclip
        included do
          field :name, type: String, localize: RocketCMS.configuration.localize
          field :h1, type: String, localize: RocketCMS.configuration.localize

          field :title, type: String, localize: RocketCMS.configuration.localize
          field :keywords, type: String, localize: RocketCMS.configuration.localize
          field :description, type: String, localize: RocketCMS.configuration.localize
          field :robots, type: String, localize: RocketCMS.configuration.localize

          field :og_title, type: String, localize: RocketCMS.configuration.localize
          has_mongoid_attached_file :og_image, styles: {thumb: "800x600>"}
        end
      end
    end
  end
end

