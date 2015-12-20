# Class: htcondor_ce::bdii
#
# This class installs and configures the
# Resource BDII for the HTCondor Computing Element
#
# Please note, must be included separately to the main class.
#
# Parameters:
#
# 
class htcondor_ce::bdii (
  $supported_vos       = $::htcondor_ce::params::supported_vos,
  $goc_site_name       = $::htcondor_ce::params::goc_site_name,
  $benchmark_result    = $::htcondor_ce::params::benchmark_result,
  $execution_env_cores = $::htcondor_ce::params::execution_env_cores,
  $election_type       = $::htcondor_ce::params::election_type,
  $election_hosts      = $::htcondor_ce::params::election_hosts,
  $ce_version          = $::htcondor_ce::params::ce_version,
) inherits htcondor_ce {

  $bdii_ce_config = '/etc/condor-ce/config.d/06-ce-bdii.conf'

  package { 'htcondor-ce-bdii':
    ensure  => $ce_version,
  }

  file { $bdii_ce_config:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template('htcondor_ce/06-ce-bdii.conf.erb'),
    require => Package['htcondor-ce-bdii'],
  }

  exec {'/usr/bin/condor_ce_reconfig':
    refreshonly => true,
  }

  File[$bdii_ce_config] ~> Exec['/usr/bin/condor_ce_reconfig']

}
