define apache::mod (
  $package = undef,
  $preloaded = false,
) {
  $module = $name
  include apache

  $mod_packages = $apache::params::mod_packages

  if $package {
    $package_REAL = $package
  } elsif $mod_packages[$module] {
    $package_REAL = $mod_packages[$module]
  }

  if $package_REAL {
    package { $package_REAL:
      ensure  => present,
      require => Package['httpd'],
    }
  }

  case $osfamily {
    'debian': {
      a2mod { $module:
        ensure => present,
      }
    }
    'redhat': {
      if ! $preloaded {
        file { "${apache::params::vdir}/00_load_${module}.conf":
          ensure  => present,
          content => "LoadModule ${module}_module modules/mod_${module}.so\n",
          owner   => '0',
          group   => '0',
          mode    => '0644',
        }
      }
    }
  }
}
