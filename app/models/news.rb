class News
  include RocketCMS::Models::News
  RocketCMS.apply_patches self
  rails_admin &RocketCMS.news_config
end
