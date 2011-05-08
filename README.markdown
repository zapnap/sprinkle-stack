Customized software install stack based on the "passenger-stack".

Needs to be run via the ruby "sprinkle" gem.

Running is as simple as:
  sprinkle -c -s config/install.rb
  
Will set up a brand new unix system with all required software to run a Rails app.
This installs supporting software and configures a "deploy" user that can deploy applications to the new machine.

It should be run from the root account of the box.
After running the provisioning, you should

* Login and change the password of the 'deploy' user
* Disallow root logins via SSH by editing the /etc/ssh/sshd_config file and setting "PermitRootLogin" to "no"
* Lock down all ports except 80, 443 (web, ssl), 22 (ssh), and 1000 (webmin)