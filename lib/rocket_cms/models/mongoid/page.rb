module RocketCMS
  module Models
    module Mongoid
      module Page
        extend ActiveSupport::Concern
        included do
          field :regexp, type: String
          field :redirect, type: String
          field :content, type: String, localize: RocketCMS.config.localize
          field :fullpath, type: String
          has_and_belongs_to_many :menus, inverse_of: :pages
          acts_as_nested_set
          scope :sorted, -> { asc(:lft) }
        end
      end
    end
  end
end
