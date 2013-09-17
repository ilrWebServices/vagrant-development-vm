# Development MySQL settings
class mysql5::dev ($mysqlpassword = $mysql5::password, $webadminuser = $mysql5::webadminuser, $webadmingroup = $mysql5::webadmingroup) inherits mysql5 {
  File['my.cnf'] {
    source => "puppet:///modules/mysql5/dev.my.cnf",
  }
}

