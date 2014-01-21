module Sortable
  extend ActiveSupport::Concern
  included do
    field :sort, type: Integer
    scope :sorted, -> { asc(:sort) }
  end
end
