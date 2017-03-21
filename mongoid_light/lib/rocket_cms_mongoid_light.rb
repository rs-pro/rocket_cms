require 'mongoid'
require 'mongoid-paperclip'
require 'glebtv-mongoid_nested_set'
require 'mongoid_slug'
require 'kaminari/mongoid'

module RocketCMS
  def self.orm
    :mongoid
  end
  def self.light?
    true
  end
end

require 'rocket_cms'
