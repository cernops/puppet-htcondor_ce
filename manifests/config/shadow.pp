# Class: htcondor_ce::shadow
#
# This class installs and configures a
# static shadow to be used for the base condor.
#
class htcondor_ce::config::shadow {
  file { '/etc/condor/config.d/41_ce_shadow.conf':
    ensure  => present,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => "SHADOW = $(SBIN)/condor_shadow_s\n",
    require => Package['condor-static-shadow'],
  }

}
