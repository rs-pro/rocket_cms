module RocketCMS
  module Models
    module Menu
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include Enableable
      include RocketCMS.orm_specific('Menu')
      include ManualSlug
      included do
        after_save do
          Rails.cache.delete 'menus'
        end
        after_destroy do
          Rails.cache.delete 'menus'
        end
        has_and_belongs_to_many :pages, inverse_of: :menus
        manual_slug :name
      end
    end
  end
end

