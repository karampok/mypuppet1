class check_mk::repo (
){
    class { 'apt':
      always_apt_update => true,
    }
    apt::source { 'omd':
      location          => 'http://labs.consol.de/OMD/debian',
      release           => 'wheezy',
      repos             => 'main',
      required_packages => 'debian-keyring debian-archive-keyring',
      key               => 'F8C1CA08A57B9ED7',
      key_server        => 'keys.gnupg.net',
      include_src       => false, 
    }
    #apt::source { 'cwc':
    #  location          => 'http://deploy1.cwc.io',
    #  release           => '',
    #  repos             => 'misc/',
    #  include_src       => false, 
    #}

}
