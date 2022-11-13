

provider "consul" {}

provider "vault" {}

data "consul_nodes" "dc1-nodes" {
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
  # bootstrap   = true
  token = data.vault_kv_secret_v2.consul.data.http_token
}
