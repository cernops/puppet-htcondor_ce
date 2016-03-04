# Class: htcondor_ce::auth
#
# This class installs and configures the
# authorization backend for HTCondorCE.
#
# Defaults to ARGUS
#
# Parameters:
#
# 
class htcondor_ce::auth::argus (
  $authz_config = $::htcondor_ce::authz_config,
) inherits htcondor_ce {

  $pep_callout = '/etc/grid-security/gsi-pep-callout-condor.conf'
  $gsi_authz   = '/etc/grid-security/gsi-authz.conf'

  package { 'argus-pep-api-c':
    ensure => present,
  }

  package { 'argus-gsi-pep-callout':
    ensure  => present,
    require => Package['argus-pep-api-c'],
  }

  file { $pep_callout:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/gsi-pep-callout.erb"),
    require => Package['argus-gsi-pep-callout'],
  }

  file { $gsi_authz:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/gsi-authz.conf",
    require => Package['argus-gsi-pep-callout'],
  }

}
