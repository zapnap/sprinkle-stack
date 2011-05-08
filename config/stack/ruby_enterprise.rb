require File.join(File.dirname(__FILE__), '../config.rb')

package :ruby_enterprise do
  description 'Ruby Enterprise Edition'
  binaries = %w(erb gem irb rackup rails rake rdoc ree-version ri ruby testrb)
  source "http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2011.03.tar.gz" do
    custom_install 'sudo ./installer --auto=/usr/local/ruby-enterprise'
    binaries.each {|bin| post :install, "ln -sf #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}" }
    # Rebuild all gems in case we updated to a newer version of Ruby
    post :install, "gem update --system"
    post :install, "gem pristine --all"
    # Passenger gets installed with an old fucked up version
    # that we don't want. Removing it saves us headache down the line
    # when we go to actually install passenger (in apache.rb).
    # post :install, "gem uninstall --version 3.0.7 -x passenger"

  end

  verify do
    has_executable_with_version(
      "#{REE_PATH}/bin/ruby", "Ruby Enterprise Edition 2011.03"
    )
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end

  requires :ree_dependencies
end

package :ree_dependencies do
  ree_packages = %w(zlib1g-dev libreadline5-dev libssl-dev)
  apt ree_packages
  verify { ree_packages.each { |pkg| has_apt pkg } }
  requires :build_essential
end
