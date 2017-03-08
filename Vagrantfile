Vagrant.configure("2") do |config|
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.force_host_vm = false
  end
end
