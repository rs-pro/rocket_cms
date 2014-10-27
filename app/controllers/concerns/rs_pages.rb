module RsPages
  extend ActiveSupport::Concern
  included do
    before_filter :find_page
  end

  private

  def find_page
    @seo_page = find_seo_page request.path
    if !@seo_page.nil? && !@seo_page.redirect.blank?
      redirect_to @seo_page.redirect, status: :moved_permanently
    end
  end

  def find_seo_page(path)
    do_redirect = false
    if path[0] != '/'
      path = '/' + path
    end
    if path.length > 1 && path[-1] == '/'
      path = path[0..-2]
      do_redirect = true
    end

    page = Page.enabled.where(fullpath: path).first
    if page.nil?
      do_redirect = true
      spath = path.chomp(File.extname(path))
      if spath != path
        page = Page.enabled.where(fullpath: spath).first
      end
    end
    if !page.nil? && do_redirect
      redirect_to path, status: :moved_permanently
    end

    page
  end

end
