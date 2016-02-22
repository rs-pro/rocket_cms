require 'awesome_nested_set'
require 'paperclip'

require 'friendly_id'
require 'validates_lengths_from_database'

module RocketCMS
  def self.orm
    :active_record
  end
end

require 'rocket_cms'
