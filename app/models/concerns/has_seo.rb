module HasSeo
  extend ActiveSupport::Concern

  included do
    has_one :seo, as: :seoable
  end
end


