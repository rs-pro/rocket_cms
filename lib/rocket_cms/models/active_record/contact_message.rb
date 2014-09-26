module RocketCMS
  module Models
    module ActiveRecord
      module ContactMessage
        extend ActiveSupport::Concern
        included do
          has_paper_trail
          validates_lengths_from_database
        end
      end
    end
  end
end

