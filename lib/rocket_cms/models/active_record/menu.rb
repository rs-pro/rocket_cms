module RocketCMS
  module Models
    module ActiveRecord
      module Menu
        extend ActiveSupport::Concern
        included do
          has_paper_trail if respond_to?(:has_paper_trail)
          validates_lengths_from_database
          if RocketCMS.config.localize
            translates :name
          end
        end
      end
    end
  end
end

