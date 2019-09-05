class profile::k8s::node {
  class { "::kubernetes":
    worker => true
  }
}