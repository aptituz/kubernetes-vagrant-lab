# Setup docker option as documented in k8s documentation:
# https://kubernetes.io/docs/setup/production-environment/container-runtimes/
class profile::k8s::docker {
  require ::profile::docker

  file { "/etc/docker":
    ensure => directory
  }
  file { "/etc/docker/daemon.json":
    ensure => file,
    content => '
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
'
  } ~>
  exec { '/bin/systemctl daemon-reload':
    refreshonly => true,
    notify => Service["docker"]
  }
}