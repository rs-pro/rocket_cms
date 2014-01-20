module Seoable
  extend ActiveSupport::Concern
  included do
    field :name, type: String
    field :h1, type: String

    field :title, type: String
    field :keywords, type: String
    field :description, type: String
    field :robots, type: String
  end

  def page_title
    title.blank? ? name : title
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
    }
  end
end

