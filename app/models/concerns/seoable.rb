module Seoable
  extend ActiveSupport::Concern
  LOCALIZED_FIELDS = [:h1, :title, :keywords, :description, :og_title]
  FIELDS = LOCALIZED_FIELDS + [:og_image, :robots]

  if Seo.separate_table?
    included do
      has_one :seo, as: :seoable, autosave: true
      accepts_nested_attributes_for :seo
      delegate *FIELDS, to: :seo
      delegate *(FIELDS.map {|f| "#{f}=".to_sym }), to: :seo
      alias seo_without_build seo
      def seo
        seo_without_build || build_seo
      end
      if RocketCMS.config.localize
        delegate *(LOCALIZED_FIELDS.map {|f| "#{f}_translations".to_sym }), to: :seo
        delegate *(LOCALIZED_FIELDS.map {|f| "#{f}_translations=".to_sym }), to: :seo
      end
    end
    include RocketCMS::SeoHelpers
  else
    include RocketCMS::Models::Seo
  end
end

