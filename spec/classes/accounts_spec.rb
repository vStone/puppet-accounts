require 'spec_helper'

describe 'accounts' do

  describe 'all parameters defined' do
    let (:params) {
      {
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

end
