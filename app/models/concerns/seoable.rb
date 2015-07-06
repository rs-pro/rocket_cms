module Seoable
  extend ActiveSupport::Concern
  include RocketCMS::Models::Seo
  
  # deprecated
  def self.seo_config
    RocketCMS.seo_config
  end
end

