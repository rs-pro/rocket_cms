module RocketCMS
  module Models
    module ActiveRecord
      module Page
        extend ActiveSupport::Concern
        extend FriendlyId

        included do
          friendly_id :name, use: [:slugged, :finders]
          has_paper_trail
        end
      end
    end
  end
end

