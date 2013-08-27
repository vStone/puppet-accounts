require 'spec_helper'

describe 'array_substract' do

  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    Puppet::Parser::Functions.function(:array_substract).should == 'function_array_substract'
  end

  describe 'should throw an error with' do
    it 'no arguments' do
      lambda {
        scope.function_array_substract([])
      }.should raise_error(Puppet::ParseError, /requires 2 arguments/)
    end

    it '1 argument' do
      lambda {
        scope.function_array_substract([['foo']])
      }.should raise_error(Puppet::ParseError, /requires 2 arguments/)
    end

    it 'more than 2 arguments' do
      lambda {
        scope.function_array_substract([['foo'],['bar'], ['foobar']])
      }.should raise_error(Puppet::ParseError, /requires 2 arguments/)
    end

    it 'wrong argument type for the first argument' do
      lambda {
        scope.function_array_substract(['foo',[]])
      }.should raise_error(Puppet::ParseError, /First argument is not an array/)
    end

    it 'wrong argument type for the second argument (arg = {})' do
      lambda {
        scope.function_array_substract([['foo'],{}])
      }.should raise_error(Puppet::ParseError, /Second argument is not an array or string/)
    end
  end

  it 'second argument as a string' do
    scope.function_array_substract([['foo','bar'], 'foo']).should == ['bar']
  end

  it 'second argument as an array' do
    scope.function_array_substract([['foo','bar','foobar'], ['foo','bar']]).should == ['foobar']
  end

end
