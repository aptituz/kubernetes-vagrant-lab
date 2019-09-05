plan playbooks::cluster (
  TargetSpec $cluster = get_targets('k8s-cluster'),
  TargetSpec $masters = get_targets('k8s-masters'),
  TargetSpec $workers = get_targets('k8s-workers'),
) {

  $cluster.apply_prep

  $masters.each |$master| {
    add_facts($master, { "role" => "k8s-master" } )
  }
  $workers.each |$worker| {
    add_facts($worker, { "role" => "k8s-node" } )
  }

  apply($masters) {
    include ::role::k8s::master

    file { "/home/vagrant/.kube":
      ensure => directory
    }

    file { "/home/vagrant/.kube/config":
      ensure => file,
      source => "/etc/kubernetes/admin.conf",
      owner  => "vagrant",
      group  => "vagrant",
    }
  }

  apply($workers) {
    include ::role::k8s::node
  }

}