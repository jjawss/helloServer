# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "hello_server"
set :repo_url, "git@github.com:jjawss/helloServer.git"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :rvm_ruby_version, '2.6.1'
set :passenger_restart_with_touch, true

set :branch, "master"

set :user, "deploy_user"
set :scm_passphrase, "password"

# set :bundle_gemfile, "hello_server/Gemfile"

set :bundle_flags,      '--quiet' # this unsets --deployment, see details in config_bundler task details
set :bundle_path,       nil
set :bundle_without,    nil

namespace :deploy do
  desc 'Config bundler'
  task :config_bundler do
    on roles(/.*/) do
      execute :bundle, :config, '--local deployment true'
      execute :bundle, :config, '--local without "development test"'
      execute :bundle, :config, "--local path #{shared_path.join('bundle')}"
    end
  end
end

before 'bundler:install', 'deploy:config_bundler'

# set :bundle_flags, --quiet
# set deploy_to, "/var/www/hello_server"

# set :bundle_path, nil
# set :bundle_jobs, 4
# set :bundle_without, nil
# set :bundle_flags, nil

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
