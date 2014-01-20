class Menu
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::ForbiddenAttributesProtection

  include Mongoid::Audit::Trackable
  track_history track_create: true, track_destroy: true

  field :name, type: String
  include ManualSlug
  manual_slug :name

  include Enableable

  has_and_belongs_to_many :pages, inverse_of: :menu

  rails_admin do
    navigation_label 'CMS'

    field :text_slug
    field :name
  end
end
