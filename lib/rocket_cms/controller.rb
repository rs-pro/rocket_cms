module RocketCMS::Controller
  extend ActiveSupport::Concern
  included do
    protect_from_forgery with: :exception

    include RsErrors
    include RsPages
    include RsMenu

    helper_method :page_title

    if Object.const_defined?('CanCan')
      rescue_from CanCan::AccessDenied do |exception|
        redirect_to '/', alert: exception.message
      end
    end
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
end
