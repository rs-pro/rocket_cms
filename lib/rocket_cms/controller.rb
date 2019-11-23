module RocketCMS::Controller
  extend ActiveSupport::Concern
  included do
    include RsErrors
    include RsPages
    include RsMenu
    #include RsCookies
    protect_from_forgery with: :exception
    helper_method :page_title
    helper_method :app_url
  end

  protected

    def page_title
      if @seo_page.nil?
        Settings.default_title
      else
        @seo_page.page_title
      end
    end

    def ckeditor_authenticate
      redirect_to '/' unless user_signed_in? && current_user.has_role?('admin')
    end

    def app_url(object)
      RocketCMS.app_url(object)
    end
end
