# This is a private class that should not be called directly.
# Use pulp::consumer instead.
class pulp::consumer::install {
  $pulp_consumer_packages = [
    'pulp-agent',
    'pulp-puppet-consumer-extensions',
    'pulp-puppet-handlers',
    'pulp-rpm-consumer-extensions',
    'pulp-rpm-handlers',
    'pulp-rpm-yumplugins',
  ]

  package { $pulp_consumer_packages:
    ensure => present,
  }

}
