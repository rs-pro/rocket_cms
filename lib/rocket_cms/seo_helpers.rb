module RocketCMS
  module SeoHelpers
    extend ActiveSupport::Concern
    def page_title
      title.blank? ? name : title
    end

    def get_og_title
      og_title.blank? ? name : og_title
    end
  end
end

