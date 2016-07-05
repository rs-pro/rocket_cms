require 'mongoid'
require 'glebtv-mongoid-paperclip'
require 'glebtv-mongoid_nested_set'
require 'mongoid-slug'
require 'kaminari-mongoid'

module RocketCMS
  def self.orm
    :mongoid
  end
  def self.light?
    true
  end
end

require 'rocket_cms'
