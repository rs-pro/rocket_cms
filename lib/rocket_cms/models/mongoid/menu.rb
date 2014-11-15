module RocketCMS
  module Models
    module Mongoid
      module Menu
        extend ActiveSupport::Concern
        included do
          field :name, type: String
        end
      end
    end
  end
end
