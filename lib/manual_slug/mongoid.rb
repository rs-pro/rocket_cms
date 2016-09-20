module ManualSlug::Mongoid
  extend ActiveSupport::Concern
  include ::Mongoid::Slug

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
        if self._slugs.blank?
          self.build_slug
        else
          self._slugs = self._slugs.map{ |s| s.strip }.select {|s| !s.blank? }
        end
        true
      end if callback
    end
  end

end


