# == Class: accounts
#
# Uses accounts::hiera to create users.
#
# === Parameters:
#
# [*groups*]:
#   Array of groups that should be present.
#
# [*users*]:
#   Array of users that should be present.
#
# [*user_uids*]:
#   A hash table connecting usernames with their uids.
#
# [*user_info*]:
#   A hash table with user information.
#
# [*user_defaults*]:
#   A hash with parameters serving as defaults for all users.
#
# [*purge*]:
#   If set to true (defaults to false), all users defined in the
#   `user_uids` hash that are NOT present in `users` will be removed
#   from the system. This removes the configured ssh keys from the
#   users homefolder.
#
class accounts (
  Array[String]       $groups        = [],
  Array[String]       $users         = [],
  Hash[String,Integer] $user_uids     = {},
  Hash[String,Hash]   $user_info     = {},
  Hash                $user_defaults = {},
  Boolean             $purge         = false,
) {

  group {$groups:
    ensure => 'present',
  }

  $create_users = select_users($users, $user_uids, $user_info, $user_defaults)
  create_resources('accounts::hiera', $create_users)

  if $purge {
    ## Gets all users that have a uid configured.
    $all_users = hash_keys($user_uids)
    ## Get the users that are not in the users array.
    $users_absent = array_substract($all_users, $users)
    ## Create a big hash containing user information (but then absent...)
    $absent_users = select_users($users_absent, $user_uids, {}, {'ensure' => 'absent'})
    create_resources('accounts::hiera', $absent_users)
  }

}
