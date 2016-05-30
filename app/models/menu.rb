if RocketCMS.active_record?
  class Menu < ActiveRecord::Base
  end
end

class Menu
  include RocketCMS::Models::Menu
  RocketCMS.apply_patches self

  if respond_to?(:rails_admin)
    rails_admin &RocketCMS.menu_config
  end
end

