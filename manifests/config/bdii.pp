# Class: htcondor_ce::bdii
#
# This class installs and configures the
# Resource BDII for the HTCondor Computing Element
#
class htcondor_ce::config::bdii {
  $bdii_ce_config      = '/etc/condor-ce/config.d/06-ce-bdii.conf'

  # used in $bdii_ce_config
  $supported_vos       = $::htcondor_ce::supported_vos
  $goc_site_name       = $::htcondor_ce::goc_site_name
  $benchmark_result    = $::htcondor_ce::benchmark_result
  $execution_env_cores = $::htcondor_ce::execution_env_cores
  $election_type       = $::htcondor_ce::election_type
  $election_hosts      = $::htcondor_ce::election_hosts

  file { $bdii_ce_config:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template("${module_name}/06-ce-bdii.conf.erb"),
    require => Package['htcondor-ce-bdii'],
  }

  File[$bdii_ce_config] ~> Exec['/usr/bin/condor_ce_reconfig']

}
