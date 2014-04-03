module RocketCMS::Models::Menu
  extend ActiveSupport::Concern

  included do
    include RocketCMS::Model
    include Enableable

    field :name, type: String

    include ManualSlug
    manual_slug :name

    has_and_belongs_to_many :pages, inverse_of: :menu

    RocketCMS.apply_patches self
    rails_admin do
      navigation_label 'CMS'
      field :text_slug
      field :name
      RocketCMS.apply_patches self
      RocketCMS.only_patches self, [:show, :list, :edit, :export]
    end
  end
end
