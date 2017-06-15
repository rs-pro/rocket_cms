module RocketCMS
  module Models
    module Mongoid
      module Page
        extend ActiveSupport::Concern
        included do
          field :qregexp, type: String
          field :redirect, type: String
          field :content, type: String, localize: RocketCMS.config.localize
          field :fullpath, type: String
          has_and_belongs_to_many :menus, inverse_of: :pages
          acts_as_nested_set
          scope :sorted, -> { asc(:lft) }

          before_save do
            self.qregexp = read_attribute(:regexp) unless has_attribute?(:qregexp) || new_record?
          end
        end

        def regexp=(value)
          self.qregexp = value
        end

        def regexp
          has_attribute?(:qregexp) ? qregexp : read_attribute(:regexp)
        end
      end
    end
  end
end
