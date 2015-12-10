class RocketCMS::URL
  include Rails.application.routes.url_helpers 

  def for(object)
    #url_for(object)
    polymorphic_url(object, routing_type: :path)
  end
end

