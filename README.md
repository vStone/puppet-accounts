# Puppet Accounts

## Description

This module is designed to store your system admins account information in hiera.
This is _not_ intended to be used to do large scale user deployments (you can try),
but rather for managing a small group of people that need to be able to login when
ldap servers die (for example).

## Requirements

* hiera

## Usage

The module will look in several different places for user specific information:

* accounts::user_uids

This append-only list contains the mappings of usernames to UIDS.
You should NEVER remove entries from here. Only adding is allowed ;)


* accounts::users

This is an array of users that have to be created on the system.

If it is defined in multiple hiera files, they will ALL be taken into account.


* accounts::user_info

A big hash mapping additional parameters to each user.
Add your ssh keys and password hashes here.


Additionally, the following parameters can be set:

* accounts::purge

If set to true, all users defined in the accounts::user_uids and
NOT in accounts::users will be PURGED from the system.

* accounts::user_defaults

A hash with default parameters to use.

## Advanced Usage

We use the accounts::hiera defined type as a wrapper to the user resource. It allows
us to specify an additional hash with parameters that are passed through to the user
resource. For example, if you would want to use `forcelocal => true` on all your resources,
you can use extra_params in combination with the `user_defaults`.


```yaml
accounts::user_defaults:
  extra_params:
    forcelocal: true
```
