require File.join(File.dirname(__FILE__), '../config.rb')

USER_GROUP = 'www-data'

package :user do
  description "Sets up default deployment user and copies SSH keys from local user for login"
  
  noop do
    pre :install, "adduser #{USER_TO_ADD} --ingroup #{USER_GROUP} --disabled-password --gecos ''"
  end

  verify { has_directory "/home/#{USER_TO_ADD}" }
  
  optional :user_install_ssh_key, :user_allow_sudo
  requires :sudo
end

package :user_install_ssh_key do
  description "Add local SSH key to authorized_keys so we can login without a password"
  
  user_ssh_path = "/home/#{USER_TO_ADD}/.ssh"
  
  transfer File.join(ENV['HOME'], '.ssh/id_rsa.pub'), "#{user_ssh_path}/authorized_keys" do
    pre :install, "mkdir -p #{user_ssh_path}"
    post :install do
      [
        "chown -R #{USER_TO_ADD}:#{USER_GROUP} #{user_ssh_path}",
        "chmod 700 #{user_ssh_path}",
        "chmod 600 #{user_ssh_path}/authorized_keys"
      ]
    end
  end
  
  verify { has_file "#{user_ssh_path}/authorized_keys" }
end

package :user_allow_sudo do
  description "Allow added user to perform sudo commands"
  
  sudo_conf = '/etc/sudoers'
  sudo_config = %Q\
# Allow #{USER_TO_ADD} user sudo
deploy ALL=NOPASSWD: ALL
  \

  push_text sudo_config, sudo_conf  
  
  verify { file_contains sudo_conf, "Allow #{USER_TO_ADD} user sudo" }
end