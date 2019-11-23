require 'awesome_nested_set'
require 'paper_trail'
require 'friendly_id'
require 'validates_lengths_from_database'

require 'geocoder'

module RocketCMS
  def self.orm
    :active_record
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
require 'rocket_navigation'

require 'rocket_cms'
require 'glebtv-ckeditor'

