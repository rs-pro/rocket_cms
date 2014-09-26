module RocketCMS
  module Models
    module Mongoid
      module Page
        extend ActiveSupport::Concern
        include ManualSlug
        included do
          field :regexp, type: String
          field :redirect, type: String
          field :content, type: String, localize: RocketCMS.configuration.localize
          field :fullpath, type: String
          has_and_belongs_to_many :menus, inverse_of: :pages

          manual_slug :name
        end
      end
    end
  end
end
