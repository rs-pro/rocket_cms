module RocketCMS
  class UrlHelper
    include ActionDispatch::Routing::PolymorphicRoutes
    include Rails.application.routes.url_helpers
  end
end

