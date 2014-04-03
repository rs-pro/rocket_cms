module RocketCMS
  module Models
    module Menu
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Enableable
      include ManualSlug

      included do
        field :name, type: String
        manual_slug :name
        has_and_belongs_to_many :pages, inverse_of: :menu
      end
    end
  end
end
