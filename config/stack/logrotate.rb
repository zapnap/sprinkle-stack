require File.join(File.dirname(__FILE__), '../config.rb')

package :logrotate do
  description 'Installs logrotate command'
  apt %w( logrotate )
  
  rails_logrotate_config = '/etc/logrotate.d/rails_apps'
  
  transfer(
    File.join(File.dirname(__FILE__), 'files/logrotate_rails.config'), 
    rails_logrotate_config
  )
  
  verify do
    has_file rails_logrotate_config
    has_executable 'logrotate'
  end
end