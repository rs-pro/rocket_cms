module RocketCMS
  module Models
    module ContactMessage
      extend ActiveSupport::Concern
      included do
        has_paper_trail
      end
    end
  end
end

