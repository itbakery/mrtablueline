require 'rvm/capistrano'
require "bundler/capistrano"
require 'sidekiq/capistrano'

default_run_options[:pty] = true
set :application, "mrtablueline"
set :keep_releases, 5
set :repository, "git@github.com:itbakery/mrtablueline.git"
set :user, "deploy"
set :scm, :git
set :run_method, :run
set :deploy_to, "/home/deploy/#{application}"
set :scm_verbose,true
set :branch, "master"
set :deploy_via, :remote_cache

set :rvm_type, :system
set :rvm_ruby_string, "ruby-1.9.3-p448"
ssh_options[:forward_agent] = true

role :web, "203.146.127.169"                          # Your HTTP server, Apache/etc
role :app, "203.146.127.169"                          # This may be the same as your `Web` server
role :db,  "203.146.127.169", :primary => true # This is where Rails migrations will run

set :bundle_cmd, "bundle"
set :sidekiq_role, :sidekiq
role :sidekiq, "203.146.127.169"
set :sidekiq_cmd, "#{bundle_cmd} exec sidekiq"
set :sidekiqctl_cmd, "#{bundle_cmd} exec sidekiqctl"
set :sidekiq_timeout, 10
set :sidekiq_role, :app
set :sidekiq_pid, "#{current_path}/tmp/pids/sidekiq.pid"
set :sidekiq_processes, 1


# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
