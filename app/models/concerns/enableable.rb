module Enableable
  extend ActiveSupport::Concern
  included do
    include BooleanField
    boolean_field(:enabled)
  end
end
