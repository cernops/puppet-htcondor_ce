# Class: htcondor_ce
#
# This class installs and configures a HTCondor Computing Element
#
# Parameters:
#
# 
class htcondor_ce(
  $pool_collector      = undef,
  $condor_views_hosts  = $::htcondor_ce::params::condor_view_hosts,
  $job_routes_template = $::htcondor_ce::params::job_routes_template,
  $ce_version          = $::htcondor_ce::params::ce_version,
  $lrms                = $::htcondor_ce::params::lrms,
  $lrms_version        = $::htcondor_ce::params::lrms_version,
  $uid_domain          = $::htcondor_ce::params::uid_domain,
  $gsi_regex           = $::htcondor_ce::params::gsi_regex,
  $gsi_backend         = $::htcondor_ce::params::gsi_backend,
  $use_static_shadow   = $::htcondor_ce::params::use_static_shadow,
  $manage_service      = $::htcondor_ce::params::manage_service,
){

  validate_string($pool_collector, $lrms, $lrms_version)
  validate_string($uid_domain, $gsi_regex)
  validate_array($condor_view_hosts)

  class { '::htcondor_ce::install': }

  class { '::htcondor_ce::config': }

  if $use_static_shadow {
    class { '::htcondor_ce::shadow': }
  }

  class { '::htcondor_ce::auth': }

  if $manage_service {
    class { '::htcondor_ce::service': }
  }
}
