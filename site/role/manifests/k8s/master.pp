class role::k8s::master {
  include ::role::base

  include ::profile::docker
  include ::profile::k8s::docker
  include ::profile::k8s::master
}