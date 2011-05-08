require File.join(File.dirname(__FILE__), '../config.rb')

package :sudo do
  description 'Installs sudo command'
  apt %w( sudo )
  
  verify do
    has_executable 'sudo'
  end
  
  requires :apache
end