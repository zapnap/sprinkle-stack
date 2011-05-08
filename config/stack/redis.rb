# Package is unstable and may not work properly.
package :redis do
  description 'Redis Database'
  version '2.2.6'
  source "http://redis.googlecode.com/files/redis-#{version}.tar.gz"  # hack
  
  push_text '', "/tmp/sprinkle-hack" do
  # i don't know why but noop method did not work, it's a pure hack

    pre :install, "sudo mkdir -p /usr/local/redis"
    pre :install, "sudo mkdir -p /etc/redis"

    pre :install, "wget #{s_ource}"
    pre :install, "tar xvf redis-#{version}.tar.gz && cd redis-#{version} && make install"

    pre :install, "sudo cp redis-#{version}/redis.conf /etc/redis/6379.conf"

    pre :install, "sudo cp redis-#{version}/utils/redis_init_script /etc/init.d/redis"
    pre :install, "sudo chmod +x /etc/init.d/redis"

    post :install, "rm -rf redis-#{version}*"
    post :install, "sudo /usr/sbin/update-rc.d -f redis defaults"
    post :install, "sudo /etc/init.d/redis start"

  end

  verify do
    has_executable '/usr/local/bin/redis-server'
    has_file '/usr/local/bin/redis-server'
  end
end
