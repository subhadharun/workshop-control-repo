class profile::bolt_student(id)_puppet_agent {

  service { 'puppet':
    ensure => running,
    enable => true
  }

}
