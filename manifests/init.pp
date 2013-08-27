# == Class: accounts
#
# Uses accounts::hiera to create users.
#
# === Parameters:
#
# $groups::       Array of groups that should be present.
#
# $users::        Array of users that should be present.
#
# $user_uids::    A hash table connecting usernames with their uids.
#
# $user_info::    A hash table with user information.
#
# === Todo:
#
# * TODO: Grab nested hiera (defined in multiple yaml definitions).
#
#
class accounts (
  $groups        = hiera_array('accounts::groups', []),
  $users         = hiera_array('accounts::users', []),
  $user_uids     = hiera_hash('accounts::user_uids', {}),
  $user_info     = hiera_hash('accounts::user_info', {}),
  $user_defaults = hiera('accounts::user_defaults', {})
) {

  if $::puppetversion =~ /^3/ {
    ## Since this is puppet 3, the values above have been initialized but without array/hash support.. redo!
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


}
