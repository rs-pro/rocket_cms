module RocketCMS
  module Models
    module ActiveRecord
      module News
        extend ActiveSupport::Concern
        included do
          has_attached_file :og_image, styles: {thumb: "800x600>"}
        end
      end
    end
  end
end


