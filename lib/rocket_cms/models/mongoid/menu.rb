module RocketCMS
  module Models
    module Mongoid
      module Menu
        extend ActiveSupport::Concern
        include ManualSlug
        included do
          field :name, type: String
          manual_slug :name
        end
      end
    end
  end
end
