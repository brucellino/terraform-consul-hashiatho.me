data "consul_nodes" "dc1_nodes" {
  query_options {
    datacenter = "dc1"
  }
}

resource "consul_acl_policy" "agent" {
  name        = "node-policy"
  description = "Consul Agent Node policy"
  datacenters = ["dc1"]
  rules       = file("${path.module}/node-policy.hcl")
}

resource "consul_acl_policy" "servers" {
  name        = "server-policy"
  description = "Consul Server policy"
  datacenters = ["dc1"]
  rules       = <<-RULE
node_prefix "server-" {
  policy = "write"
}
node_prefix "" {
  policy = "read"
}
service_prefix "" {
  policy = "read"
}
  RULE
}


resource "consul_acl_token" "agents" {
  description = "my test token"
  policies    = [consul_acl_policy.agent.name]
}

data "vault_kv_secret_v2" "consul" {
  mount = "hashiatho.me-v2"
  name  = "consul"
}

resource "vault_consul_secret_backend" "main" {
  path        = "consul"
  description = "Manages the Consul backend"
  address     = var.consul_http_addr
  token       = data.vault_kv_secret_v2.consul.data.http_token
  # token = "69d1ce5a-1845-ae66-d2a6-b1fff32097a3"
}

resource "vault_consul_secret_backend_role" "main" {
  name            = "consul-server-role"
  backend         = vault_consul_secret_backend.main.path
  consul_policies = [consul_acl_policy.servers.name]
  # service_identities = []
  node_identities = [for id in data.consul_nodes.dc1_nodes.node_ids : "${id}"]
}
