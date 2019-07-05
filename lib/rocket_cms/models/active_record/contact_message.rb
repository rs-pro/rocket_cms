module RocketCMS
  module Models
    module ActiveRecord
      module ContactMessage
        extend ActiveSupport::Concern
        included do
          has_paper_trail if respond_to?(:has_paper_trail)
          validates_lengths_from_database

          after_commit :send_notification!, on: :create
        end
      end
    end
  end
end

