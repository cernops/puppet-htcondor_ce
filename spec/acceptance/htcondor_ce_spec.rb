require 'spec_helper_acceptance'

describe 'htcondor_ce' do
    it 'should configure and work with no errors' do
      pp = <<-EOS
         class{"htcondor_ce":
         }
      EOS
      # Run it two times, it should be stable by then
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
      # Trival test for now.
      shell('sleep 10', :acceptable_exit_codes => 0)
    end
end
