module Trackable
  extend ActiveSupport::Concern
  include Mongoid::Audit::Trackable
  included do
    track_history track_create: true, track_destroy: true
  end
end

