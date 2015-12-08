require 'spec_helper'
describe 'htcondorce' do

  context 'with defaults for all parameters' do
    it { should contain_class('htcondorce') }
  end
end
