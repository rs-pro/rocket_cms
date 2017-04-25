module RsCookies
  extend ActiveSupport::Concern
  included do
    def set_cookies_on!
      cookies.permanent['cookies_on'] = {
          value: "1",
          httponly: false,
      } if cookies['cookies_on'].nil? || cookies['cookies_on'] != "1"
    end
    before_action :set_cookies_on!
  end
end
