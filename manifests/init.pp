# == Class: erlang
#
# Module to install an up-to-date version of Erlang from the
# official repositories 
#
# === Parameters
# [*version*]
#   The package version to install, passed to ensure.
#   Defaults to present.
#
#
class erlang(
  $version = 'present',
) {
  include apt
  validate_string($version)
  validate_re($::osfamily, '^Debian$', 'This module uses a debian repository')

  apt::source { 'erlang':
    location   => 'http://binaries.erlang-solutions.com/debian',
    repos      => 'contrib',
    key        => 'A14F4FCA',
    #key_source => 'http://binaries.erlang-solutions.com/debian/erlang_solutions.asc',
  }

  package { 'erlang':
    ensure  => $version,
    require => Apt::Source['erlang'],
  }
}
