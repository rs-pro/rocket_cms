module Seoable
  extend ActiveSupport::Concern
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

  def self.seo_config
    Proc.new {
      active false
      label "SEO"
      field :h1, :string
      field :title, :string
      field :keywords, :string
      field :description, :string
      field :robots, :string

      field :og_title, :string
      field :og_image
    }
  end
end

