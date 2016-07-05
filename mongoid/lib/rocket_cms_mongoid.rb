require 'mongoid'
require 'glebtv-mongoid-paperclip'
require 'glebtv-mongoid_nested_set'
require 'mongoid-audit'
require 'mongoid-slug'
require 'kaminari_mongoid'
require 'geocoder'

module RocketCMS
  def self.orm
    :mongoid
  end
  def self.light?
    false
  end
end

require 'devise'
require 'simple_form'
require 'rocket_cms/simple_form_patch'
require 'glebtv-simple_captcha'
require 'rails_admin'
require 'rails_admin_nested_set'
require 'rails_admin_toggleable'
require 'rails_admin_settings'
require 'sitemap_generator'
require 'simple-navigation'

require 'rocket_cms'
require 'glebtv-ckeditor'

