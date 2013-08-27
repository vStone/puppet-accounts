module Puppet::Parser::Functions

  newfunction(:array_substract, :type => :rvalue) do |args|
    raise Puppet::ParseError, "array_substract(): requires 2 arguments, got #{args.length}" if args.length != 2
    first = args.shift
    second = args.shift

    raise Puppet::ParseError, "array_substract(): First argument is not an array" unless first.is_a?(Array)
    raise Puppet::ParseError, "array_substract(): Second argument is not an array or string" unless (second.is_a?(Array) or second.is_a?(String))

    second = [second] unless second.is_a?(Array)


    first - second
  end

end
