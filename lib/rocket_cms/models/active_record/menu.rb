module RocketCMS
  module Models
    module ActiveRecord
      module Menu
        extend ActiveSupport::Concern
        included do
          friendly_id :report_slug, use: [:slugged, :finders]
          has_paper_trail
          validates_lengths_from_database
        end
      end
    end
  end
end

