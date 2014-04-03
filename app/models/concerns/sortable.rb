module Sortable
  extend ActiveSupport::Concern
  include SortField
  
  included do
    sort_field
  end
end
