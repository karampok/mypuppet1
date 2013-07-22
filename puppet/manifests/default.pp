


#package { "apache2":
#  ensure  => present,
#  require => Exec["apt-get update"],
#}

#service { "apache2":
#  ensure  => "running",
#  require => Package["apache2"],
#}

#file { "/var/www/webapp":
#  ensure  => "link",
#  target  => "/mydata",
#  require => Package["apache2"],
#  notify  => Service["apache2"],
#}


