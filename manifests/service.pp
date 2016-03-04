class htcondor_ce::service {
  service { 'condor-ce':
    ensure => 'running',
    enable => true,
  }
}
