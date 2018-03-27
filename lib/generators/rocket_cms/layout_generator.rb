require 'rails/generators'
require File.expand_path('../utils', __FILE__)

module RocketCms
  class LayoutGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../..", __FILE__)
    include Generators::Utils::InstanceMethods

    desc 'RocketCMS Layout generator'
    def layout
      template('app/views/layouts/application.slim', 'app/views/layouts/application.slim')
      template('app/views/blocks/_footer.slim', 'app/views/blocks/_footer.slim')
      template('app/views/blocks/_header.slim', 'app/views/blocks/_header.slim')
      template('app/views/pages/home/index.slim', 'app/views/pages/home/index.slim')
    end
  end
end

