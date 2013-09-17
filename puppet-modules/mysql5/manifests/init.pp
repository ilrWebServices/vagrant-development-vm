class mysql5($mysqlpassword, $webadminuser = "root", $webadmingroup = "root") {
  package { "mysql-server":
    ensure => installed,
  }
  package { "mysql":
    name => [
      "mysql-client",
      "mysql-common",
    ],
    ensure => installed,
    require => Package['mysql-server'],
  }

  # TODO: This only does the initial set, it won't reset it.
  # exec { "Set MySQL server root password":
  #   refreshonly => true,
  #   unless => "/usr/bin/mysqladmin -uroot -p$mysqlpassword status",
  #   command => "mysqladmin -uroot password $mysqlpassword",
  #   require => Package['mysql']
  # }

  # exec { "set-mysql-password":
  #   unless => "/usr/bin/mysqladmin -uroot -p$mysqlpassword status",
  #   command => "mysqladmin -uroot password $mysqlpassword",
  #   require => Package["mysql"],
  # }

  file { 'my.cnf':
    path => "/etc/mysql/my.cnf",
    owner => 'root',
    group => 'root',
    mode => 644,
    source => "puppet:///modules/mysql5/my.cnf",
    require => Package['mysql'],
    notify => Service['mysql'],
  }

  service { 'mysql':
    enable => 'true',
    ensure => 'running',
    provider => 'upstart',
    require => Package['mysql-server'],
  }

  file { "root-mycnf":
    path => "/root/.my.cnf",
    content => template("mysql5/my.cnf.erb"),
    owner => root,
    require => Package['mysql']
  }

  file { "admin-mycnf":
    path => "/home/$webadminuser/.my.cnf",
    content => template("mysql5/my.cnf.erb"),
    owner => $webadminuser,
    group => $webadmingroup,
    require => Package['mysql']
  }

  file { 'restore-mysql-tab-backup':
    path => "/usr/local/bin/restore-mysql-tab-backup",
    owner => root,
    group => root,
    mode => 755,
    source => "puppet:///modules/mysql5/restore-mysql-tab-backup",
    require => Package['mysql']
  }
}
