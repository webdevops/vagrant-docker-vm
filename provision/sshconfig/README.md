# SSH configuration

The CliTools can build a shared (via git) ssh configuration.
The tools reads the configuration from /vagrant/provision/sshconfig and generate the
/home/vagrant/.ssh/config file.

## Configuration files

Default configuration (only one is processed, in this order):

- /home/vagrant/.ssh/config.default (User default host)
- /vagrant/provision/sshconfig/default.conf (Shared default configuration)
- (Internal clitool defaults)

Host configuration files:

- /vagrant/provision/sshconfig/*conf
- /home/vagrant/.ssh/config.user

## Automatic rebuilding

With this Vagrant VM CliTools SSH configuration building is automatically processed with
incron. If the user edits /home/vagrant/.ssh/config.default or /home/vagrant/.ssh/config.user
the /home/vagrant/.ssh/config file is automatically recreated.