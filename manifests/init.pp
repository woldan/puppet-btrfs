class btrfs {
  package { "btrfs-tools" :
    ensure => present,
  }
}
