module Sortable
  extend ActiveSupport::Concern
  included do
    include SortField
    sort_field
  end
end
