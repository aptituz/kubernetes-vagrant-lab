class profile::base (
  Array[String] $packages,
  Hash[String, String] $hosts,
) {
  ensure_packages($packages)

  $hosts.each  |$hostname, $ip| {
    host { $hostname:
      ensure => present,
      ip     => $ip,
    }
  }
}