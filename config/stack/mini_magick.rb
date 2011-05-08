require File.join(File.dirname(__FILE__), '../config.rb')

package :mini_magick do
  description "Allows manipulation of image files from Ruby/Rails"
  gem 'mini_magick'
  
  verify do
    has_gem 'mini_magick'
  end
  
  requires :ruby_enterprise
  requires :image_magick
end

package :image_magick do
  description "Provides image manipulation library for mini_magick gem"
  apt %w( imagemagick libfreetype6-dev xml-core )
  verify do
    has_apt 'imagemagick'
    has_apt 'libfreetype6-dev'
    has_apt 'xml-core'
  end
end