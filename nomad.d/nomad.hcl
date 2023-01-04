data_dir  = "/mnt/storage/nomad"
bind_addr = "0.0.0.0"

name = "tengu_nomad"
datacenter = "hoori-nomad"

# Enable server on nomad1
server {
  enabled = true
  bootstrap_expect = 3
}

# Enable client on nomad1
client {
  enabled = true
#  network_interface = "{{ GetPrivateInterfaces | include \"network\" \"192.168.68.0/24\" | attr \"name\" }}"
  servers = ["192.168.68.241:4667","192.168.68.242:4667","192.168.68.243:4667"]
}

ports {
  http = 4646
}

# Enable raw_exec driver
plugin "raw_exec" {
  config {
    enabled = true
  }
}

plugin "docker" {
  config {
    allow_privileged = true
    volumes {
      enabled = true
    }
    extra_labels = ["job_name", "job_id", "task_group_name", "task_name", "namespace", "node_name", "node_id"]
  }
}
