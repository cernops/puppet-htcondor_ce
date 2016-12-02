class htcondor_ce::config (
  $job_router_schedd2_pool = ['tweetybird01.cern.ch','condorcm1.cern.ch'],
  $condor_view_host        = ['cecollector1.cern.ch:9619','collector1.opensciencegrid.org:9619', 'collector2.opensciencegrid.org:9619'],
  $worker_nodes            = [],
  $computing_elements      = [],
  $schedds                 = [],
  $managers                = [],
  $gsi_dn_prefix           = "/DC=ch/DC=cern/OU=computers/CN=",
  $gsi_dn_suffix           = ".*",
  $uid_domain              = 'cern.ch',
)
{
  $main_ce_conf   = '/etc/condor-ce/config.d/60-configured-attributes.conf'
  $site_ce_sec    = '/etc/condor-ce/config.d/59-site-security.conf'
  $condor_mapfile = '/etc/condor-ce/condor_mapfile'
  $pep_callout    = '/etc/grid-security/gsi-pep-callout-condor.conf'
  $gsi_authz      = '/etc/grid-security/gsi-authz.conf'
  $ce_sysconf     = '/etc/sysconfig/condor-ce'

  $pool_collector_str  = join(suffix($job_router_schedd2_pool, ':9618'), ', ')

  file { $main_ce_conf:
    ensure  => file,
    owner   => condor,
    group   => condor,
    mode    => '0644',
    content => template('htcondor_ce/60-configured-attributes.conf.erb'),
  }

  file{ $site_ce_sec:
    ensure  => file,
    owner   => condor,
    group   => condor,
    mode    => '0644',
    content => template('htcondor_ce/59-site-security.conf.erb'),
  }

  file { $condor_mapfile:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('htcondor_ce/condor_mapfile.erb'),
  }

  file { $pep_callout:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('htcondor_ce/gsi-pep-callout.erb'),
  }

  file { $gsi_authz:
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/htcondor_ce/gsi-authz.conf",
  }

  file { $ce_sysconf:
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/htcondor_ce/syconfig-condor-ce",
  }

  $config_files = [File[$main_ce_conf],File[$pep_callout],File[$gsi_authz],File[$ce_sysconf]]

  exec {'/usr/bin/condor_ce_reconfig':
    refreshonly => true,
  }

  $config_files ~> Exec['/usr/bin/condor_ce_reconfig']
}
