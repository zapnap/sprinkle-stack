require File.join(File.dirname(__FILE__), '../config.rb')

package :ntpdate do
  description 'Keeps clocks current and set to UTC'
  apt %w( ntpdate )
  
  verify do
    has_apt 'ntpdate'
  end
  
  requires :build_essential
end