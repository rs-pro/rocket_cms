if RocketCMS.active_record?
  class Page < ActiveRecord::Base
  end
end

class Page
  include RocketCMS::Models::Page
  RocketCMS.apply_patches self
  rails_admin &RocketCMS.page_config
end
