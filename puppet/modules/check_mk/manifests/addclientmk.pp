define check_mk::addclientmk (
 $cname='testname', 
 $ip='testip', 
 $site='monitor',
 $host_groups = undef,
) {
    $etc_dir = "/omd/sites/${site}/etc"
    $bin_dir = "/omd/sites/${site}/bin"
    file { "/omd/sites/$site/etc/check_mk/conf.d/c$cname.mk":
        owner   => 'monitor',
        group   => 'monitor',
        mode    => '0644',
        content => template('/mydata/addclient.erb'),
    require   => Class['check_mk::install'],
        #notify  => Service[apache2]
        notify => Exec['check_mk-refresh']
    }
    # re-read config if it changes
    #exec { 'check_mk-refresh-host':
    #    command     => "/bin/su -l -c '${bin_dir}/check_mk -I' ${cname}",
    #    refreshonly => true,
    #    notify      => Exec['check_mk-reload'],
    #}
}
