module Puppet::Parser::Functions

  newfunction(:hash_keys, :type => :rvalue) do |args|
    raise Puppet::ParseError, "hash_keys(): requires 1 argument, got #{args.length}" if args.length != 1

    hash = args.shift

    raise Puppet::ParseError, "hash_keys(): Argument is not an hash" unless hash.is_a?(Hash)
    hash.keys

  end

end
