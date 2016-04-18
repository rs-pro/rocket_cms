module RocketCMS
  module Controllers
    module Search
      extend ActiveSupport::Concern
      def index
        if params[:query].blank?
          @results = []
        else
          if RocketCMS.mongoid?
            @results = Mongoid::Elasticsearch.search({
              body: {
                query: {
                  query_string: {
                    query: Mongoid::Elasticsearch::Utils.clean(params[:query])
                  }
                },
                highlight: {
                  require_field_match: false,
                  fields: {
                    name: {
                      number_of_fragments: 1,
                      size_of_fragments: 120
                    },
                    content: {
                      number_of_fragments: 1,
                      size_of_fragments: 220
                    }
                  }
                }
              }},
              page: params[:page],
              per_page: RocketCMS.config.search_per_page,
            )
          else
            @results = PgSearch.multisearch(params[:query]).page(params[:page]).per(RocketCMS.config.search_per_page)
          end
        end
      end
    end
  end
end
