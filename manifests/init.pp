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
# [*hiera_merge*]:
#   When specifying users and groups on multiple levels in a hiera
#   hierarchy, set this to true to refetch the parameters with
#   either hiera_array or hiera_hash.
#
#
class accounts (
  $groups        = [],
  $users         = [],
  $user_uids     = {},
  $user_info     = {},
  $user_defaults = {},
  $purge         = false,
  $hiera_merge   = false,
) {

  if $hiera_merge {
    $_groups    = hiera_array('accounts::groups', [])
    $_users     = hiera_array('accounts::users', [])
    $_user_uids = hiera_hash('accounts::user_uids', {})
    $_user_info = hiera_hash('accounts::user_info', {})
  } else {
    $_groups    = $groups
    $_users     = $users
    $_user_uids = $user_uids
    $_user_info = $user_info
  }

  group {$groups:
    ensure => 'present',
  }

  $create_users = select_users($_users, $_user_uids, $_user_info, $user_defaults)
  create_resources('accounts::hiera', $create_users)

  if $purge {
    ## Gets all users that have a uid configured.
    $all_users = hash_keys($_user_uids)
    ## Get the users that are not in the users array.
    $users_absent = array_substract($all_users, $_users)
    ## Create a big hash containing user information (but then absent...)
    $absent_users = select_users($users_absent, $_user_uids, {}, {'ensure' => 'absent'})
    create_resources('accounts::hiera', $absent_users)
  }

}
