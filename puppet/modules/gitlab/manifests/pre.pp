# Class:: gitlab::pre
#
#
class gitlab::pre {

  include gitlab

  $git_home       = $gitlab::git_home
  $git_user       = $gitlab::git_user
  $git_comment    = $gitlab::git_comment
  $gitlab_dbtype  = $gitlab::gitlab_dbtype
  $gitlab_dbname  = $gitlab::gitlab_dbname
  $gitlab_dbuser  = $gitlab::gitlab_dbuser
  $gitlab_dbpwd   = $gitlab::gitlab_dbpwd

  user {
    $git_user:
      ensure     => present,
      shell      => '/bin/bash',
      password   => '*',
      home       => $git_home,
      comment    => $git_comment,
      system     => true;
  }

  mysql::db { $gitlab_dbname:
    user     => $gitlab_dbuser,
    password => $gitlab_dbpwd, #only string no int
    host     => 'localhost',
    grant    => ['all']
  }

    file {"${git_home}/.gitconfig":
        content => template('gitlab/git.gitconfig.erb'),
        mode    => '0644',
        require   => File["$git_home"];
    }


  file {
    $git_home:
      ensure  => directory,
      owner   => $git_user,
      group   => $git_user,
      require => User[$git_user],
      mode    => '0755',
  }
    file { '/usr/bin/python2':
       ensure => 'link',
       target => '/usr/bin/python',
    }

  # try and decide about the family here,
  # deal with version/dist specifics within the class
  case $::osfamily {
    'Debian': {
      $db_packages = $gitlab_dbtype ? {
        mysql => ['libmysql++-dev','libmysqlclient-dev'],
        pgsql => ['libpq-dev', 'postgresql-client'],
      }

      package {
        ['git-core',
          'libicu-dev','python2.7',
          'libxml2-dev','libxslt1-dev','python-dev','postfix']:
            ensure  => installed;
      }
    } # Debian pre-requists
    'Redhat': {
      $db_packages = $gitlab_dbtype ? {
        mysql => ['mysql-devel'],
        pgsql => ['postgresql-devel'],
      }

      package {
        ['perl-Time-HiRes',
          'libicu-devel','libxml2-devel','libxslt-devel',
          'python-devel','libcurl-devel','readline-devel','openssl-devel',
          'zlib-devel','libyaml-devel']:
            ensure   => latest,
            provider => yum;
      }

    } # Redhat pre-requists
    default: {
      err "${::osfamily} not supported yet"
    }
  }

  package {
    $db_packages:
      ensure   => installed;
  }

  package {
    ['openssh-server','git','curl', 'build-essential', 'nginx','redis-server']:
      ensure => installed;
  }

} # Class:: gitlab::pre
