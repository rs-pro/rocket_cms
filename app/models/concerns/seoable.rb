module Seoable
  extend ActiveSupport::Concern
  if RocketCMS.mongoid?
    include ::Mongoid::Paperclip
  end
  
  included do
    if RocketCMS.mongoid?
      field :name, type: String, localize: RocketCMS.configuration.localize
      field :h1, type: String, localize: RocketCMS.configuration.localize

      field :title, type: String, localize: RocketCMS.configuration.localize
      field :keywords, type: String, localize: RocketCMS.configuration.localize
      field :description, type: String, localize: RocketCMS.configuration.localize
      field :robots, type: String, localize: RocketCMS.configuration.localize

      field :og_title, type: String, localize: RocketCMS.configuration.localize
      has_mongoid_attached_file :og_image, styles: {thumb: "800x600>"}
    elsif RocketCMS.active_record?
      has_attached_file :og_image, styles: {thumb: "800x600>"}
    end
    validates_attachment_content_type :og_image, content_type: %w(image/gif image/jpeg image/jpg image/png), if: :og_image?
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

