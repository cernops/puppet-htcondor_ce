# Class: htcondor_ce
# 
# This class manages HTCondor-CE
# == Parameters:
#
# [*job_router_schedd2_pool*]
# Defines the main collector for your pool.
# Defaults: 'condorcm1.cern.ch'
#
# [*condor_view_host*]
# Comma separated list of other HTCondor-CEs in the pool and their collector ports.
# e.g. ce503.cern.ch:9619, ce504.cern.ch:9619
# Default: []
#
# [*condor_ce_version*]
# Provide a version number for package installation, so we don't receive any unexpected
# upgrade surprises.
# Default: '1.13-1.osgup.el6'

class htcondor_ce (
  $job_router_schedd2_pool = 'condorcm1.cern.ch',
  $condor_view_host        = [],
  $condor_ce_version       = '1.13-1.el6',
  $condor_version          = '8.3.5-315103.el6',
  $lrms                    = 'condor',
  $worker_nodes            = [],
  $computing_elements      = [],
  $schedds                 = [],
  $managers                = [],
  $gsi_dn_prefix           = "/DC=ch/DC=cern/OU=computers/CN=",
  $gsi_dn_suffix           = ".*",
  $uid_domain              = 'cern.ch',
)
{
  class {'htcondor_ce::install':
    condor_ce_version => $condor_ce_version,
    condor_version    => $condor_version,
  }

  class {'htcondor_ce::config':
    worker_nodes       => $worker_nodes,
    computing_elements => $computing_elements,
    schedds            => $schedds,
    managers           => $managers,
  }

  Class['htcondor_ce::install'] -> Class['htcondor_ce::config']
}
