class SearchController < ApplicationController
  def index
    if Rails.env.development?
      # trigger autoload so models are registered in Mongoid::Elasticearch
      RocketCMS.configuration.search_models.map(&:constantize)
    end
    @results = Mongoid::Elasticsearch.search({
      body: {
        query: {
          query_string: {
            query: Mongoid::Elasticsearch::Utils.clean(params[:query])
          }
        },
        highlight: {
          fields: {
            name: {},
            content: {}
          }
        }
      }},
      page: params[:page],
      per_page: RocketCMS.configuration.search_per_page,
    )
  end
end
