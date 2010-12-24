# -*- coding: utf-8 -*-
set :application, "regional"
set :repository,  "git://github.com/ruby-no-kai/regional_rubykaigi.git"
set :branch, "master"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{application}/railsapp"
set :ssh_options, { :forward_agent => true }

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :git_shallow_clone, 1

set :use_sudo, false
set :runner, "regional"
ssh_options[:username] = application

set :production_server, "linode.rubykaigi.org"
set :port, 2022
role :app, production_server
role :web, production_server
role :db,  production_server, :primary => true

def setup_shared(dir, path)
  src = "#{shared_path}/#{dir}/#{path}"
  dest = "#{latest_release}/#{dir}/#{path}"
  run "! test -e #{dest} && ln -s #{src} #{dest}"
end

def setup_shared_config(path)
  setup_shared("config", path)
end

require 'net/http'
require 'uri'
def notify_irc_cat
  task_name = ARGV.shift.chomp
  message = "[regional.rubykaigi.org] cap #{task_name} => done"
  Net::HTTP.version_1_1
  Net::HTTP.get_print 'alpha.kakutani.com', "/send/#{URI.escape(message)}", 3489
end

namespace :deploy do
  task :config_symlink do
    setup_shared("db", "production.sqlite3")
    setup_shared("vendor", "bundle")
    setup_shared_config("config_action_controller_session.rb")
    setup_shared_config("initializers/site_keys.rb")
    setup_shared_config("initializers/app_config.rb")
  end

  desc "Restart Passenger"
  task :restart do
    run "touch #{latest_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
  end

#  task :after_restart do
#    notify_irc_cat
#  end
end
after 'deploy:update_code', 'deploy:config_symlink'

namespace :bundler do
  task :bundle do
    run("cd #{latest_release} && bundle install #{shared_path}/vendor/bundle --deployment --without development test cucumber")
  end
end

after 'deploy:finalize_update', 'bundler:bundle'
