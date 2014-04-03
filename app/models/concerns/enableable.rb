module Enableable
  extend ActiveSupport::Concern
  include BooleanField
  
  included do
    boolean_field(:enabled)
  end
end
