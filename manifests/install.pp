class htcondor_ce::install (
  $condor_ce_version = present,
  $condor_version    = present,
  $lrms              = 'condor',
)
{
  package{ 'globus-rsl':
    ensure => present,
  }

  package{ 'blahp':
    ensure => present,
  }

  package{ "htcondor-ce-${lrms}":
    ensure   => $condor_ce_version,
    require  => [Package['condor'], Package['blahp'],Package['globus-rsl']],
  }
}
