if RocketCMS.active_record?
  class News < ActiveRecord::Base
  end
end

class News
  include RocketCMS::Models::News
  RocketCMS.apply_patches self

  if respond_to?(:rails_admin)
    rails_admin &RocketCMS.news_config
  end
end
