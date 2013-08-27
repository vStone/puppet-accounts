require 'spec_helper'

describe 'hash_keys' do

  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    Puppet::Parser::Functions.function(:hash_keys).should == 'function_hash_keys'
  end

  describe 'should throw an error with' do
    it 'no arguments' do
      lambda {
        scope.function_hash_keys([])
      }.should raise_error(Puppet::ParseError, /requires 1 argument/)
    end

    it 'more than 1 arguments' do
      lambda {
        scope.function_hash_keys(['foo','bar'])
      }.should raise_error(Puppet::ParseError, /requires 1 argument/)
    end

    it 'wrong argument type' do
      lambda {
        scope.function_hash_keys(['foo'])
      }.should raise_error(Puppet::ParseError, /Argument is not an hash/)
    end
  end

  it 'should return hash keys' do
    scope.function_hash_keys([{'foo' => 'somehting', 'bar' => []}]).sort.should == ['foo','bar'].sort
  end
end
