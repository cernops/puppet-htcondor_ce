# Class: htcondor_ce::install
#
# This class installs a HTCondor Computing Element
#
# Parameters:
#
class htcondor_ce::install {
  $ce_version        = $::htcondor_ce::ce_version
  $lrms              = $::htcondor_ce::lrms
  $lrms_version      = $::htcondor_ce::lrms_version
  $use_static_shadow = $::htcondor_ce::use_static_shadow
  $install_bdii      = $::htcondor_ce::install_bdii

  package { ['globus-rsl', 'blahp', 'empty-ca-certs']: ensure => present, }

  package { ['htcondor-ce', 'htcondor-ce-client', "htcondor-ce-${lrms}"]:
    ensure  => $ce_version,
    require => Package['condor', 'blahp', 'globus-rsl', 'empty-ca-certs'],
  }

  if $install_bdii {
    package { 'htcondor-ce-bdii': ensure => $ce_version, }
  }

  if $use_static_shadow {
    package { 'condor-static-shadow': ensure => "${lrms_version}", }
  }

}
