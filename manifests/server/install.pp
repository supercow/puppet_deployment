# This is a private class that should not be called directly.
# Use pulp::server instead.

class pulp::server::install {

    $pulp_server_pkgs = ['pulp-server','pulp-puppet-plugins','pulp-rpm-plugins','pulp-selinux']
    package { $pulp_server_pkgs:
      ensure => present,
    }

    if pulp::server::node_parent {
        package { 'pulp-nodes-parent':
          ensure => 'installed'
        }
    }

    Package[$pulp_server_pkgs] -> Package['pulp-nodes-parent']
}
