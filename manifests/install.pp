# Class: htcondor_ce::install
#
# This class installs a HTCondor Computing Element
#
# Parameters:
#
# 
class htcondor_ce::install (
  $ce_version         = $::htcondor_ce::ce_version,
  $lrms               = $::htcondor_ce::lrms,
  $lrms_version       = $::htcondor_ce::lrms_version,
  $use_static_shadow  = $::htcondor_ce::use_static_shadow,
) inherits htcondor_ce {

  class {'::htcondor_ce::repos':}

  package { 'globus-rsl':
    ensure => present,
  }

  package { 'blahp':
    ensure => present,
  }

  package { "htcondor-ce-${lrms}":
    ensure  => $ce_version,
    require => Package['condor', 'blahp', 'globus-rsl'],
  }
}
