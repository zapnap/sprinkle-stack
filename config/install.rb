# Loads all files in our "stack"
$:<< File.dirname(__FILE__) << File.join(File.dirname(__FILE__), 'stack')
Dir[File.join(File.dirname(__FILE__), 'stack', '*.rb')].each { |lib| require File.basename(lib) }

require 'config'

policy :rails_stack, :roles => :app do
  # Configuration
  requires :ntpdate
  requires :user
  requires :iptables_appserver
  # Web / app stack
  requires :ruby_enterprise # Ruby Enterprise Edition
  requires :webserver # Apache
  requires :appserver # Passenger
  # Mysql Client
  requires :database_client
  # Support apps
  requires :logrotate
  requires :git
  requires :redis
  requires :monit
  # Rails app stack
  requires :mini_magick
  requires :rails_log_analyzer
  requires :resque
  requires :gitolite
end

policy :db_stack, :roles => :db do
  # Config
  requires :ntpdate
  requires :user
  requires :iptables_database
  # Support apps
  requires :logrotate
  # Servers
  requires :database_server
  # requires :sphinx
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'deploy'
    end
  end
 
  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end

# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', ">= 0.2.3" 
rescue Gem::LoadError
  puts "sprinkle 0.2.3 required.\n Run: `sudo gem install sprinkle`"
  exit
end
