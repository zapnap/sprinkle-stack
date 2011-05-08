require File.join(File.dirname(__FILE__), '../config.rb')

package :iptables, :provides => :firewall do
  description "Provides firewall for servers"
  apt 'iptables'
  
  verify do
    has_apt 'iptables'
  end
end

package :iptables_database do
  requires :iptables
end

package :iptables_appserver do
  requires :iptables
end