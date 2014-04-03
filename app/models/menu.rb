class Menu
  include RocketCMS::Models::Menu
  RocketCMS.apply_patches self
  rails_admin &RocketCMS.menu_config
end

