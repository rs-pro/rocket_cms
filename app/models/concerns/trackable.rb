module Trackable
  extend ActiveSupport::Concern
  included do
    include Mongoid::Audit::Trackable
    track_history track_create: true, track_destroy: true
  end
end

