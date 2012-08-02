class apache::mod::ssl {
  apache::mod { 'ssl':
    package => $apache::params::mod_ssl_package,
  }
}
