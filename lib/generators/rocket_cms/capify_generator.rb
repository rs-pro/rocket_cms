require 'rails/generators'

module RocketCms
  class CapifyGenerator < Rails::Generators::Base
    argument :domain, type: :string
    argument :port, type: :string, optional: true

    source_root File.expand_path('../templates', __FILE__)

    def app_name
      Rails.application.class.name.split("::")[0]
    end

    def deploy_to
      "/data/#{app_name.downcase}/app"
    end
    def tmp_path
      "/data/#{app_name.downcase}/tmp_dump"
    end

    desc 'RocketCMS capistrano setup generator'
    def install
      copy_file "Capfile", "Capfile"
      unless port.nil?
        template "unicorn.erb", "config/unicorn/production.rb"
      end
      template "deploy.erb", "config/deploy.rb"
      template "production.erb", "config/deploy/production.rb"
      template "dl.erb", "lib/tasks/dl.thor"
    end
  end
end

