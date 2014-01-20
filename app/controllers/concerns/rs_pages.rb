module RsPages
  extend ActiveSupport::Concern
  included do
    before_filter :find_page
  end

  private

  def find_page
    @seo_page = find_seo_page request.path
    if !@seo_page.nil? && !@seo_page.redirect.blank?
      redirect_to @seo_page.redirect
    end
  end

  def find_seo_page(path)
    if path[0] != '/'
      path = '/' + path
    end

    page = Page.enabled.where(fullpath: path).first
    if page.nil?
      spath = path.chomp(File.extname(path))
      if spath != path
        page = Page.enabled.where(fullpath: spath).first
      end
    end

    page
  end

end
