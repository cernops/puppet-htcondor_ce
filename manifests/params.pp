# Class: htcondor_ce::params
class htcondor_ce::params {
  $condor_view_hosts   = ['collector1.opensciencegrid.org:9619', 'collector2.opensciencegrid.org:9619']
  $job_routes_template = 'htcondor_ce/job_routes.conf.erb'
  $ce_version          = '1.20-1.el6'
  $lrms                = 'condor'
  $lrms_version        = '8.3.8-1.el6'
  $uid_domain          = $::domain
  $gsi_regex           = '^\/DC\=ch\/DC\=cern\/OU\=computers\/CN\=(host\/)?([A-Za-z0-9.\-]*)$'
  $gsi_backend         = 'argus'
  $use_static_shadow   = true
  $manage_service      = true
  $argus_server        = 'site-argus.cern.ch'
  $argus_port          = 8154
  $argus_resourceid    = 'http://authz-interop.org/xacml/resource/resource-type/ce'

  # bdii parameters
  $install_bdii        = true
  $supported_vos       = hiera_array('htcondor_ce::supported_vos', ['atlas', 'cms', 'alice', 'lhcb', 'dteam'])
  $goc_site_name       = ''
  $benchmark_result    = '10.00-HEP-SPEC06'
  $execution_env_cores = 16
  $election_type       = 'leader'
  $election_hosts      = $::fqdn
}
