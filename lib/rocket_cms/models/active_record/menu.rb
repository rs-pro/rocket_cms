module RocketCMS
  module Models
    module ActiveRecord
      module Menu
        extend ActiveSupport::Concern
        included do
          friendly_id :report_slug, use: [:slugged, :finders]
          has_paper_trail
        end
      end
    end
  end
end

