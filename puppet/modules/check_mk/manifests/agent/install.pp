class check_mk::agent::install (
  $version,
  $filestore,
  $workspace,
) {
  if ! defined(Package['xinetd']) {
    package { 'xinetd':
      ensure => present,
    }
  }
  if $filestore {
    if ! defined(File[$workspace]) {
      file { $workspace:
        ensure => directory,
      }
    }

    file {"${workspace}/check-mk-agent_${version}_all.deb":
      ensure  => present,
      source  => "${filestore}/check-mk-agent_${version}_all.deb",
      require => Package['xinetd'],
    }
    package { 'check_mk-agent':
      ensure   => present,
      provider => 'dpkg',
      require  => File["${workspace}/check-mk-agent_${version}_all.deb"],
      source   => "${workspace}/check-mk-agent_${version}_all.deb",
    }

    file { "${workspace}/check-mk-agent-logwatch_${version}_all.deb":
      ensure  => present,
      source  => "${filestore}/check-mk-agent-logwatch_${version}_all.deb",
      require => Package['xinetd'],
    }


    package { 'check_mk-agent-logwatch':
      ensure   => present,
      provider => 'dpkg',
      source   => "${workspace}/check-mk-agent-logwatch_${version}_all.deb",
      require  => [
        File["${workspace}/check-mk-agent-logwatch_${version}_all.deb"],
        Package['check_mk-agent'],
      ],
    }
  }
  else {
    package { 'check_mk-agent':
      ensure  => present,
      require => Package['xinetd'],
    }
    package { 'check_mk-agent-logwatch':
      ensure  => present,
      require => Package['check_mk-agent'],
    }
  }
}
