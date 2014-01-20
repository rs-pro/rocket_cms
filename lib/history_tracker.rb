# app/models/history_tracker.rb
class HistoryTracker
  include Mongoid::Audit::Tracker
end
