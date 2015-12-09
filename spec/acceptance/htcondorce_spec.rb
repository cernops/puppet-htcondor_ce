require 'spec_helper_acceptance'

describe 'htcondorce' do
    it 'should configure and work with no errors' do
      pp = <<-EOS
         class{"htcondorce":
         }
      EOS
      # Run it two times, it should be stable by then
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
      # Trival test for now.
      shell('sleep 10', :acceptable_exit_codes => 0)
    end
end
