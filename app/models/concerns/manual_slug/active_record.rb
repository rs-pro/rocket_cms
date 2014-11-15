module ManualSlug::ActiveRecord
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
  end

  def text_slug
    slug
  end
  def text_slug=(s)
    self.slug = s
  end

  module ClassMethods
    def manual_slug(field, options = {}, callback = true)
      friendly_id field, use: [:slugged, :finders]
    end
  end
end

