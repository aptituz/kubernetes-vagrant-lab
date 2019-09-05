class role::k8s::node {
  require ::role::base
  include ::profile::docker
  include ::profile::k8s::docker
  include ::profile::k8s::node
}
