# Class: htcondor_ce
#
# This class installs and configures a HTCondor Computing Element
#
# Parameters:
#
class htcondor_ce (
  $pool_collectors     = $::htcondor_ce::params::pool_collectors,
  $condor_view_hosts   = $::htcondor_ce::params::condor_view_hosts,
  $job_routes_template = $::htcondor_ce::params::job_routes_template,
  $ce_version          = $::htcondor_ce::params::ce_version,
  $lrms                = $::htcondor_ce::params::lrms,
  $lrms_version        = $::htcondor_ce::params::lrms_version,
  $uid_domain          = $::htcondor_ce::params::uid_domain,
  $gsi_regex           = $::htcondor_ce::params::gsi_regex,
  $gsi_backend         = $::htcondor_ce::params::gsi_backend,
  $use_static_shadow   = $::htcondor_ce::params::use_static_shadow,
  $manage_service      = $::htcondor_ce::params::manage_service,
  # for argus
  $argus_server        = $::htcondor_ce::params::argus_server,
  $argus_port          = $::htcondor_ce::params::argus_port,
  $argus_resourceid    = $::htcondor_ce::params::argus_resourceid,
  # for bdii
  $install_bdii        = $::htcondor_ce::params::install_bdii,
  $supported_vos       = $::htcondor_ce::params::supported_vos,
  $goc_site_name       = $::htcondor_ce::params::goc_site_name,
  $benchmark_result    = $::htcondor_ce::params::benchmark_result,
  $execution_env_cores = $::htcondor_ce::params::execution_env_cores,
  $election_type       = $::htcondor_ce::params::election_type,
  $election_hosts      = $::htcondor_ce::params::election_hosts,
  ) inherits htcondor_ce::params {
  validate_string($lrms, $lrms_version)
  validate_string($uid_domain, $gsi_regex)
  validate_array($condor_view_hosts, $pool_collectors)
  validate_bool($manage_service, $use_static_shadow, $install_bdii)

  class { '::htcondor_ce::install': }

  class { '::htcondor_ce::config': }

  class { '::htcondor_ce::auth': }

  if $manage_service {
    class { '::htcondor_ce::service': }
  }

}
