set :stage, :production

server '<%= domain %>', user: '<%= app_name.downcase %>', roles: %w{web app db}

set :rails_env, 'production'
set :unicorn_env, 'production'
set :unicorn_rack_env, 'production'

