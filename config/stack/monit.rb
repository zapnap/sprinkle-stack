require File.join(File.dirname(__FILE__), '../config.rb')

package :monit do
  description 'Monit to ensure processes are up'
  apt %w( monit ) do
    post :install, "mkdir -p /etc/monit/conf"
    # Allows start up of monit
    post :install, "echo 'startup=1' > /etc/default/monit"
  end
  
  monit_config = '/etc/monit/monitrc'
  transfer(
    File.join(File.dirname(__FILE__), 'files/monitrc.config'), 
    monit_config
  ) do 
    # Monit won't start if there's nothing to include in the conf file,
    # even an empty dummy file.
    post :install, "touch /etc/monit/conf/dummy.conf"
    post :install, "/etc/init.d/monit start"
  end
  
  verify do
    has_apt 'monit'
    has_process 'monit'
    file_contains monit_config, "Monit control file"
  end
end
