require 'mongoid'
require 'glebtv-mongoid-paperclip'
require 'glebtv-mongoid_nested_set'
require 'mongoid-audit'
require 'mongoid_slug'

require 'geocoder'

module RocketCMS
  def self.orm
    :mongoid
  end
end

require 'rocket_cms'
require 'glebtv-ckeditor'

