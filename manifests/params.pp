# Class: apache::params
#
# This class manages Apache parameters
#
# Parameters:
# - The $user that Apache runs as
# - The $group that Apache runs as
# - The $apache_name is the name of the package and service on the relevant
#   distribution
# - The $php_package is the name of the package that provided PHP
# - The $ssl_package is the name of the Apache SSL package
# - The $apache_dev is the name of the Apache development libraries package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class apache::params {
  $user          = 'www-data'
  $group         = 'www-data'
  $ssl           = true
  $template      = 'apache/vhost-default.conf.erb'
  $priority      = '25'
  $servername    = ''
  $serveraliases = ''
  $auth          = false
  $redirect_ssl  = false
  $options       = 'Indexes FollowSymLinks MultiViews'
  $vhost_name    = '*'

  case $::osfamily {
    'redhat': {
      $apache_name  = 'httpd'
      $vdir         = '/etc/httpd/conf.d/'
      $mod_packages = {
        'python' => 'mod_python',
        'perl'   => 'mod_perl',
        'php'    => 'php',
        'wsgi'   => 'mod_wsgi',
        'fcgid'  => 'mod_fcgid',
        'ssl'    => 'mod_ssl',
        'dev'    => 'httpd-devel',
      }
    }
    'debian': {
      $apache_name  = 'apache2'
      $vdir         = '/etc/apache2/sites-enabled/'
      $mod_packages = {
        'python' => 'libapache2-mod-python',
        'perl'   => 'libapache2-mod-perl2',
        'php'    => 'libapache2-mod-php5',
        'wsgi'   => 'libapache2-mod-wsgi',
        'fcgid'  => 'libapache2-mod-fcgid',
        'ssl'    => 'apache-ssl',
        'dev'    => ['libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev'],
      }
    }
  }
}
