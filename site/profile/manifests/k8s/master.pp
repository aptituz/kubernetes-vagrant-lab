class profile::k8s::master {
  class { "::kubernetes":
    controller => true,
  }
}