require 'rails/generators'

module RocketCms
  class WebpackGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    def app_name
      Rails.application.class.name.split("::")[0]
    end

    desc 'RocketCMS webpack generator'
    def install
      copy_file ".babelrc", ".babelrc"
      copy_file "webpack.config.js", "config/webpack.config.js"

      copy_file "webpack/application.es6", "webpack/application.es6"
      copy_file "webpack/application.sass", "webpack/application.sass"

      copy_file "webpack/errors/index.es6", "webpack/errors/index.es6"
      copy_file "webpack/errors/index.sass", "webpack/errors/index.sass"
      copy_file "webpack/errors/errors.handlebars", "webpack/errors/errors.handlebars"

      copy_file "webpack/flash/index.es6", "webpack/flash/index.es6"
      copy_file "webpack/flash/index.sass", "webpack/flash/index.sass"

      remove_file "package.json"
      template "package.json", "package.json"
    end
  end
end

