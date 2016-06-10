require 'spec_helper'

describe 'select_users' do

  describe 'should throw an error with' do
    it 'less than 3 arguments' do
      is_expected.to run.with_params('test', {}).and_raise_error(Puppet::ParseError, /requires 3 or 4 arguments/)
    end

    it 'more than 4 arguments' do
      is_expected.to run.with_params('test', {}, {}, {}, 'foo').and_raise_error(Puppet::ParseError, /requires 3 or 4 arguments/)
    end

    describe 'wrong type for' do
      it 'the users argument' do
        is_expected.to run.with_params(false, {}, {}).and_raise_error(Puppet::ParseError, /first argument \(users\) is not a/)
      end

      it 'the user_uids argument' do
        is_expected.to run.with_params('foo', 'bar', {}).and_raise_error(Puppet::ParseError, /second argument \(user_uids\) is not a/)
      end

      it 'the user_info argument' do
        is_expected.to run.with_params('foo', {}, 'bar').and_raise_error(Puppet::ParseError, /third argument \(user_info\) is not a/)
      end

      it 'the user_default argument' do
        is_expected.to run.with_params('foo', {}, {}, 'bar').and_raise_error(Puppet::ParseError, /fourth argument \(user_defaults\) is not a/)
      end
    end

    it 'when the user is not found in user_uids' do
      is_expected.to run.with_params('foo', {}, {}).and_raise_error(Puppet::ParseError, /is not found in user_uids/)

    end
  end


  context 'with a single user' do
    let (:users) { 'foo' }
    let (:user_uids) { { 'foo' => '1000',} }
    let (:user_info) { { 'foo' => { 'foobar' => 'something' } } }
    it do
      is_expected.to run.with_params(users, user_uids, user_info).and_return({'foo' => {
        'uid' => '1000',
        'foobar' => 'something',
      }})
    end
  end
  context 'with an array of users' do
    let (:users) { ['foo','bar'] }
    let (:user_uids) { { 'foo' => '1000', 'bar' => '1001','funky' => '1002' } }
    it do
      is_expected.to run.with_params(users, user_uids, {}, {}).and_return({'foo' => {'uid' => '1000', }, 'bar' => {'uid' => '1001', } })
    end
  end
  context 'with user defaults' do
    let (:user_uids) { { 'foo' => '1000', 'bar' => '1001','funky' => '1002' } }
    let (:user_defaults) { { 'shell' => '/bin/bash' } }
    it do
      is_expected.to run.with_params(['foo'], user_uids, {}, user_defaults).and_return({ 'foo' => {'uid' => '1000', 'shell' => '/bin/bash' } })
    end
  end

end
