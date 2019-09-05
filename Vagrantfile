# Vagrantfile to configure a three-node kubernetes cluster
servers = [
    {
        :name => "k8s-master-1",
        :type => "master",
        :box => "bento/ubuntu-18.04",
        :eth1 => "192.168.205.10",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "k8s-node-1",
        :type => "node",
        :box => "bento/ubuntu-18.04",
        :eth1 => "192.168.205.11",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "k8s-node-2",
        :type => "node",
        :box => "bento/ubuntu-18.04",
        :eth1 => "192.168.205.12",
        :mem => "2048",
        :cpu => "2"
    }
]

Vagrant.configure("2") do |config|

    servers.each do |opts|
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.box_version = opts[:box_version]
            config.vm.hostname = opts[:name]
            config.vm.network :private_network, ip: opts[:eth1]

            config.vm.provider "virtualbox" do |v|

                v.name = opts[:name]
                v.customize ["modifyvm", :id, "--groups", "/KubeLab"]
                v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]

            end

            config.ssh.insert_key = false
            config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
            config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"

            # we cannot use this because we can't install the docker version we want - https://github.com/hashicorp/vagrant/issues/4871
            #config.vm.provision "docker"
            #
            # config.vm.provision "shell", inline: $configureBox
            #
            # if opts[:type] == "master"
            #     config.vm.provision "shell", inline: $configureMaster
            # else
            #     config.vm.provision "shell", inline: $configureNode
            # end

        end

    end

end
