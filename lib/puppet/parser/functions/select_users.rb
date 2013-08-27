module Puppet::Parser::Functions

  newfunction(
    :select_users,
    :type => :rvalue,
    :doc => <<-EODOC
      This function creates a hashtable containing all defined users combined
      with the user uids and user information.

      Arguments:
        users         - array or string
        user_uids     - hash mapping users to uids
        user_info     - hash mapping users to additional information (keys, password, homedir, ...)
        user_defaults - hash which will be used as default parameters for each created user.
    EODOC
  ) do |args|
    raise Puppet::ParseError, "select_users(): requires 3 or 4 arguments, got #{args.length}" unless [3,4].include?(args.length)
    users     = args.shift
    user_uids = args.shift
    user_info = args.shift
    user_defaults = args.shift || {}

    raise Puppet::ParseError, "select_users(): first argument (users) is not an array or string." unless (users.is_a?(Array) or users.is_a?(String))
    raise Puppet::ParseError, "select_users(): second argument (user_uids) is not a hash." unless user_uids.is_a?(Hash)
    raise Puppet::ParseError, "select_users(): third argument (user_info) is not a hash." unless user_info.is_a?(Hash)
    raise Puppet::ParseError, "select_users(): fourth argument (user_defaults) is not a hash." unless user_defaults.is_a?(Hash)


    hash = {}
    [users].flatten.each do |user|
      function_warning(["select_users(): User '#{user}' has ensure set in user_info. This will override the value in user_defaults."]) if user_info[user] and user_info[user].keys.include?('ensure')
      raise Puppet::ParseError, "select_users(): User '#{user}' is not found in user_uids." unless user_uids.keys.include?(user)

      hash[user] = {}
      hash[user]['uid'] = user_uids[user]
      hash[user].merge!(user_info[user]) if user_info.keys.include?(user)
      hash[user].merge!(user_defaults)
    end
    hash

  end
end
