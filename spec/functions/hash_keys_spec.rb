require 'spec_helper'

describe 'hash_keys' do

  describe 'should throw an error with' do

    it 'no arguments' do
      is_expected.to run.with_params().and_raise_error(Puppet::ParseError, /requires 1 argument/)
    end

    it 'more than 1 arguments' do
      is_expected.to run.with_params('foo','bar').and_raise_error(Puppet::ParseError, /requires 1 argument/)
    end

    it 'wrong argument type' do
      is_expected.to run.with_params('foo').and_raise_error(Puppet::ParseError, /Argument is not an hash/)
    end
  end

  it 'should return hash keys' do
    is_expected.to run.with_params({'foo' => 'somehting', 'bar' => []}).and_return(['foo','bar'])
  end
end
