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
class htcondor_ce::auth (
  $gsi_backend = $::htcondor_ce::gsi_backend,
) inherits htcondor_ce {

  if $gsi_backend != 'argus' {
    fail("This module currently doesn't support backends other than ARGUS.")
  }
  else {
    class {"::htcondor_ce::auth::${gsi_backend}":}
  }

}
