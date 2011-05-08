require File.join(File.dirname(__FILE__), '../config.rb')

package :resque do
  description 'Resque, Redis-based job processing queue'
  
  gem 'resque' do
    post :install, "ln -sf #{REE_PATH}/bin/resque /usr/local/bin/resque"
  end
  
  transfer(
    File.join(File.dirname(__FILE__), 'files/resque_monit.config'), 
    '/etc/monit/conf/resque'
  ) do
    pre :install, "mkdir -p /etc/monit/conf"
    post :install, "/etc/init.d/monit restart"
  end
  
  verify do
    has_gem 'resque'
    has_executable '/usr/local/bin/resque'
    has_file '/etc/monit/conf/resque'
  end
  
  requires :redis
  requires :ruby_enterprise
  requires :monit
end
