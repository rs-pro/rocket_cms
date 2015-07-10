if RocketCMS.active_record?
  class Seo < ActiveRecord::Base
  end
end

class Seo
  include RocketCMS::Models::Seo
  RocketCMS.apply_patches self
  rails_admin &RocketCMS.seo_config
  belongs_to :seoable, polymorphic: true

  def self.separate_table?
    (RocketCMS.mongoid? && RocketCMS.config.separate_seo_table) || (RocketCMS.active_record? && Seo.table_exists?)
  end
end

