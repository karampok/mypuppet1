class check_mk (
  $filestore   = undef,
  $host_groups = undef,
  $package     = 'omd',
  $site        = 'monitoring',
  $workspace   = '/tmp',
) {
  class { 'check_mk::repo':
  }->
  class { 'check_mk::install':
    filestore => $filestore,
    package   => $package,
    site      => $site,
    workspace => $workspace,
  }->class { 'check_mk::config':
    host_groups => $host_groups,
    site        => $site,
  }

  class { 'check_mk::service':
    require   => Class['check_mk::config'],
  }


}
