require 'spec_helper'
describe 'htcondor_ce' do

  context 'with defaults for all parameters' do
    it { should contain_class('htcondor_ce') }
  end
end
