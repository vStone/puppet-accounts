require 'spec_helper'

describe 'accounts' do

  describe 'all parameters defined' do
    context 'purge => false' do
      let (:params) {
        {
          :purge         => false,
          :users         => ['foo'],
          :user_uids     => { 'foo' => '1000', 'bar' => '1001',},
          :user_info     => { },
          :user_defaults => { },
        }
      }
      it do
        should contain_user('foo').with_ensure('present')
        should_not contain_user('bar')
      end
    end

    context 'purge => true' do
      let (:params) {
        {
          :purge         => true,
          :users         => ['foo'],
          :user_uids     => { 'foo' => '1000', 'bar' => '1001',},
          :user_info     => { },
          :user_defaults => { },
        }
      }
      it do
        should contain_user('foo').with_ensure('present')
        should contain_user('bar').with_ensure('absent')
      end
    end
  end

end
