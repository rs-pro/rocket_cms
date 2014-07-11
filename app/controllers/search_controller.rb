class SearchController < ApplicationController
  def index
    if params[:query].blank?
      @results = []
    else
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
end
