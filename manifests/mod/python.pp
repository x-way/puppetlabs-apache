class apache::mod::python {
  include apache

  apache::mod { 'python':
    package => $apache::params::mod_python_package,
  }
}
