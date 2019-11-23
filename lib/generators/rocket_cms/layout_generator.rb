require 'rails/generators'
require File.expand_path('../utils', __FILE__)

module RocketCms
  class LayoutGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../..", __FILE__)
    include Generators::Utils::InstanceMethods

    desc 'RocketCMS Layout generator'
    def layout
      template('app/views/layouts/application.slim', 'app/views/layouts/application.slim')
      template('app/views/components/_header.slim', 'app/views/components/_header.slim')
      template('app/views/components/_footer.slim', 'app/views/components/_footer.slim')
      template('app/views/components/_counters.html', 'app/views/components/_counters.html')
      template('app/views/home/index.slim', 'app/views/home/index.slim')
      template('app/views/pages/show.slim', 'app/views/pages/show.slim')
    end
  end
end

