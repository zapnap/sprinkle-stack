require File.join(File.dirname(__FILE__), '../config.rb')

package :build_essential do
  description 'Build tools'
  apt 'build-essential' do
    pre :install, 'apt-get update'
  end
  verify { has_apt 'build-essential' }
end
