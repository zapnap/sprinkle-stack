Sprinkle Stack
==============

A customized Rails server install stack based on "passenger-stack" by
Ben Schwarz and some related work by Seth Banks (subimage).

Needs to be run via the ruby "sprinkle" gem. Edit the config.rb file to
set up the appropriate IP addresses and other configuration variables.
Or customize the software that gets installed by editing install.rb.

Running is as simple as:

    sprinkle -c -s config/install.rb

Will set up a brand new Unix system with all required software to run a Rails app.
This installs supporting software and configures a "deploy" user that can deploy 
applications to the new machine. Tested with Ubuntu 10.02.

After provisioning, you should:

* Login and change the password of the 'deploy' user
* Disallow root logins via SSH by editing the sshd_config file and setting "PermitRootLogin" to "no"
* Lock down all ports except 80, 443 (web, ssl), 22 (ssh), and 1000 (webmin)
