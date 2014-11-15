module ManualSlug
  extend ActiveSupport::Concern
  if RocketCMS.mongoid?
    include ManualSlug::Mongoid
  else
    include ManualSlug::ActiveRecord
  end
end

