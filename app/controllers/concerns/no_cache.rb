module NoCache
  extend ActiveSupport::Concern
  included do
    before_filter :set_cache_buster
  end
  
  protected
  def set_cache_buster
    expires_now()
    response.headers["Pragma"] = "no-cache"
  end
end
