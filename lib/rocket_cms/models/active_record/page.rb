module RocketCMS
  module Models
    module ActiveRecord
      module Page
        extend ActiveSupport::Concern

        included do
          acts_as_nested_set

          extend FriendlyId
          friendly_id :name, use: [:slugged, :finders]
          has_paper_trail
          validates_lengths_from_database only: [:name, :title, :content, :excerpt, :h1, :keywords, :robots, :og_title, :regexp, :redirect, :fullpath]

          scope :sorted, -> { order(lft: :asc) }
        end
      end
    end
  end
end

