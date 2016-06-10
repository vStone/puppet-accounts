require 'spec_helper'

describe 'array_substract' do

  describe 'should throw an error with' do
    it 'no arguments' do
      is_expected.to run.with_params().and_raise_error(Puppet::ParseError, /requires 2 arguments/)
    end

    it '1 argument' do
      is_expected.to run.with_params(['foo']).and_raise_error(Puppet::ParseError, /requires 2 arguments/)
    end

    it 'more than 2 arguments' do
      is_expected.to run.with_params(['foo'],['bar'], ['foobar']).and_raise_error(Puppet::ParseError, /requires 2 arguments/)
    end

    it 'wrong argument type for the first argument' do
      is_expected.to run.with_params('foo', []).and_raise_error(Puppet::ParseError, /First argument is not an array/)
    end

    it 'wrong argument type for the second argument (arg = {})' do
      is_expected.to run.with_params(['foo'],{}).and_raise_error(Puppet::ParseError,/Second argument is not an array or string/)
    end
  end

  it 'second argument as a string' do
    is_expected.to run.with_params(['foo','bar'], 'foo').and_return(['bar'])
  end

  it 'second argument as an array' do
    is_expected.to run.with_params(['foo','bar','foobar'], ['foo','bar']).and_return(['foobar'])
  end

end
