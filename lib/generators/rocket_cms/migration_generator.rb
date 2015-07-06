require 'rails/generators'
require 'rails/generators/active_record'

module RocketCms
  class MigrationGenerator < Rails::Generators::Base
    include ActiveRecord::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    desc 'RocketCMS migration generator'
    def install
      if RocketCMS.active_record?
        %w(contact_messages news pages seos).each do |table_name|
          migration_template "migration_#{table_name}.rb", "db/migrate/rocket_cms_create_#{table_name}.rb"
        end
      end
    end
  end
end

