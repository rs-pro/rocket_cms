module ManualSlug
  extend ActiveSupport::Concern
  included do
    include Mongoid::Slug
  end

  def text_slug
    self._slugs.empty? ? '' : self._slugs.last
  end
  def text_slug=(slug)
    if slug.blank?
      self._slugs = []
    else
      self._slugs.delete(slug)
      self._slugs << slug
    end
  end

  module ClassMethods
    def manual_slug(field, options = {}, callback = true)
      options.merge!(permanent: true, history: true)
      slug field, options

      # we will create slugs manually when needed
      skip_callback :create, :before, :build_slug

      before_validation do
        self._slugs = self._slugs.map{ |s| s.strip }.select {|s| !s.blank? }

        if self._slugs.empty?
          self.build_slug
        end

        true
      end if callback
    end
  end

end

