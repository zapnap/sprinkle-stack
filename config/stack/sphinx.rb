require File.join(File.dirname(__FILE__), '../config.rb')

package :sphinx do
  description 'MySQL full text search engine'
  version '0.9.9'
  source "http://www.sphinxsearch.com/downloads/sphinx-#{version}.tar.gz"

  apt %w( libaspell-dev aspell-de aspell-en aspell-fr aspell-es )

  verify do
    has_executable "searchd"
  end

  requires :database_server
end
