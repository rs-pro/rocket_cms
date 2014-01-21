class Menu
  include RocketCMS::Model
  include Enableable

  field :name, type: String
  manual_slug :name

  has_and_belongs_to_many :pages, inverse_of: :menu

  rails_admin do
    navigation_label 'CMS'

    field :text_slug
    field :name
  end
end
