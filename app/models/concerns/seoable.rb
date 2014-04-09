module Seoable
  extend ActiveSupport::Concern
  include Mongoid::Paperclip
  
  included do
    field :name, type: String
    field :h1, type: String

    field :title, type: String
    field :keywords, type: String
    field :description, type: String
    field :robots, type: String

    field :og_title, type: String
    has_mongoid_attached_file :og_image, styles: {thumb: "800x600>"}
  end

  def page_title
    title.blank? ? name : title
  end

  def get_og_title
    og_title.blank? ? name : og_title
  end
  
  def self.admin
    RocketCMS.seo_config
  end
  
  # deprecated
  def self.seo_config
    RocketCMS.seo_config
  end
end

