require File.join(File.dirname(__FILE__), '../config.rb')

package :git do
  description 'Git Distributed Version Control'
  apt 'git-core'
  verify do
    has_apt 'git-core'
  end
  
  requires :build_essential
end