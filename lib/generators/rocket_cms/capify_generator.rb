require 'rails/generators'

module RocketCms
  class CapifyGenerator < Rails::Generators::Base
    argument :kind, type: :string
    argument :port, type: :string
    argument :domain, type: :string

    source_root File.expand_path('../templates', __FILE__)

    def app_name
      Rails.application.class.name.split("::")[0]
    end

    def deploy_to
      if kind == 'data'
        '/data/#{fetch :application}/app'
      else
        '/home/#{fetch :user}/#{fetch :application}'
      end
    end
    def tmp_path
      if kind == 'data'
        '/data/#{fetch :application}/tmp_dump'
      else
        '/home/#{fetch :user}/tmp_dump'
      end
    end

    desc 'RocketCMS capistrano setup generator'
    def install
      copy_file "Capfile", "Capfile"
      copy_file "unicorn.rb", "config/unicorn/production.rb"
      copy_file "deploy.rb", "config/deploy.rb"
      copy_file "production.rb", "config/deploy/production.rb"
      copy_file "dl.thor", "lib/tasks/dl.thor"
    end
  end
end

