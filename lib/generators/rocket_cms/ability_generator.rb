require 'rails/generators'
require File.expand_path('../utils', __FILE__)

module RocketCms
  class AbilityGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    include Generators::Utils::InstanceMethods
    
    desc 'RocketCMS CanCan Ability config generator'
    def ability
      template 'ability.erb', 'app/models/ability.rb'
    end
  end
end

