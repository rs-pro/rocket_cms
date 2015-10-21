module RocketCMS::Search
  extend ActiveSupport::Concern
  included do
    if RocketCMS.mongoid?
      include Mongoid::Elasticsearch
      elasticsearch!({
      index_options: {
        settings: {
          index: {
            analysis: {
              analyzer: {
                my_analyzer: {
                  type: "snowball",
                  language: "Russian"
                }
              }
            }
          }
        }
      },
      index_mapings: {
        name: {type: 'string', boost: 10, analyzer: 'my_analyzer'},
        content: {type: 'string', boost: 1, analyzer: 'my_analyzer'},
      }
      })
    else
      include PgSearch
      multisearchable against: [:name, :content]
    end

    def es_index?
      enabled
    end
    def as_indexed_json
      {name: name, content: SmartExcerpt.strip_tags(content)}
    end
  end
end
