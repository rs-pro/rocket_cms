module Enableable
  extend ActiveSupport::Concern
  included do
    field :enabled, type: Mongoid::Boolean, default: true
    scope :enabled, -> { where(enabled: true) }
  end
end
