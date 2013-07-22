class check_mk::service {
  if ! defined(Service[xinetd]) {
    service { 'xinetd':
      ensure => 'running',
      enable => true,
    }
  }
  service { 'omd-1.00':
    ensure => 'running',
    enable => true,
  }
}
