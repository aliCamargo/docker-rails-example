require 'spec_helper'

describe 'unicorn', if: ENV['ROLE'] == 'web' do
  describe service('unicorn') do
    it { is_expected.not_to be_enabled }
    it { is_expected.to be_running }
    it { is_expected.to be_running.under('supervisor') }
  end

  describe file('/var/run/unicorn.sock') do
    it { is_expected.to be_socket }
  end

  describe file('/var/www/app/log/unicorn.stderr.log') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to contain 'listening on addr=/var/run/unicorn.sock fd=' }
    its(:content) { is_expected.to contain 'worker=0 ready' }
    its(:content) { is_expected.to contain 'worker=1 ready' }
    its(:content) { is_expected.to contain 'master process ready' }
  end
end
