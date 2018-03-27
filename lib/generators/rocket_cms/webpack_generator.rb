require 'rails/generators'

module RocketCms
  class WebpackGenerator < Rails::Generators::Base
    argument :port, type: :string

    source_root File.expand_path('../templates', __FILE__)
    def app_name
      Rails.application.class.name.split("::")[0]
    end

    desc 'RocketCMS webpack generator'
    def install
      copy_file ".babelrc", ".babelrc"

      copy_file "webpack/common/mixins.sass", "webpack/common/mixins.sass"
      copy_file "webpack/common/variables.sass", "webpack/common/variables.sass"
      copy_file "webpack/common/index.sass", "webpack/common/index.sass"

      copy_file "webpack/errors/errors.pug", "webpack/errors/errors.pug"
      copy_file "webpack/errors/index.es6", "webpack/errors/index.es6"
      copy_file "webpack/errors/index.sass", "webpack/errors/index.sass"

      copy_file "webpack/flash/index.es6", "webpack/flash/index.es6"
      copy_file "webpack/flash/index.sass", "webpack/flash/index.sass"

      copy_file "webpack/fonts/index.sass", "webpack/fonts/index.sass"
      copy_file "webpack/fonts/mixin.sass", "webpack/fonts/mixin.sass"

      copy_file "webpack/layout/buttons.sass", "webpack/layout/buttons.sass"
      copy_file "webpack/layout/index.sass", "webpack/layout/index.sass"
      copy_file "webpack/layout/main.sass", "webpack/layout/main.sass"
      copy_file "webpack/layout/typography.sass", "webpack/layout/typography.sass"

      copy_file "webpack/blocks/index.es6", "webpack/blocks/index.es6"
      copy_file "webpack/blocks/header/index.sass", "webpack/blocks/header/index.sass"
      copy_file "webpack/blocks/footer/index.sass", "webpack/blocks/footer/index.sass"

      copy_file "webpack/pages/index.es6", "webpack/pages/index.es6"
      copy_file "webpack/pages/home/index.es6", "webpack/pages/home/index.es6"

      copy_file "webpack/analytics.es6", "webpack/analytics.es6"
      copy_file "webpack/application.es6", "webpack/application.es6"

      remove_file "package.json"

      template "package.json", "package.json"
      template "webpack.config.js", "config/webpack.config.js"
    end
  end
end

