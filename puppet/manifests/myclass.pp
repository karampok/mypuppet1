class common {
    exec { "apt-get update":
      path => "/usr/bin",
    }
    package { "tmux":
      ensure  => present,
      require => Exec["apt-get update"],
    }

    file { "/home/vagrant/.tmux.conf":
      ensure  => "link",
      target  => "/mydata/tmux.conf_ubuntu",
      require => Package["tmux"],
    }
}

class deploygitlab {
    file { '/etc/motd':
       content => "Welcome to the gitLAB server machine!
                   Managed by karampok.\n"
    }

   #maybe can be dangerous
    class { 'mysql::server':
      config_hash => {'root_password' => 'kalimera'}
    }

    #should be some variables 
    class {
       'gitlab':
         git_email         => 'gitlab@cway.ch',
         git_comment       => 'GitLab',
         gitlab_domain     => 'gitlab.cway.ch',
         gitlab_dbtype     => 'mysql',
         gitlab_dbname     => 'gitlabdb',
         gitlab_dbuser     => 'gitlabu',
         gitlab_dbpwd      => 'foobar',
         ldap_enabled      => false,
        #should be a require to the db
     }



    #ask marko about ruby1.8 stage


    #you should do git config user gitlab in templates gitconfig.erb otherwise there is bug

    #sudo cp lib/support/init.d/gitlab /etc/init.d/gitlab
    #sudo chmod +x /etc/init.d/gitlab
    #sudo update-rc.d gitlab defaults 21
    #sudo service gitlab start
    #verified 

    #debug with two commands
    #bundle exec rake gitlab:env:info RAILS_ENV=production
    #bundle exec rake gitlab:check RAILS_ENV=production

}



class monserver {
    exec { "apt-get update":
      path => "/usr/bin",
    }

    file { '/etc/motd':
       content => "Welcome to the monSERVER machine!
                   Managed by karampok.\n"
    }

    class { 'check_mk':
      #filestore => 'puppet:///files',
      #package   => 'omd-1.00_0.wheezy_amd64.deb',
      site => 'monitor',
    }
}


class monclient {
    file { '/etc/motd':
       content => "Welcome to the monCLIENT machine!
                   Managed by karampok.\n"
    }

    class { 'check_mk::agent':
      version => '1.2.2p2-2',
      filestore => 'puppet:///files',
      workspace => '/tmp',
      ip_whitelist => [ '192.168.60.11', '192.168.60.1' ],
    }

}


class puppetmaster {
 file { '/etc/motd':
       content => "Welcome to the PUPPETMASTER machine!
                   Managed by karampok.\n"
    }

}
