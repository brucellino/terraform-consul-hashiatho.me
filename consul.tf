

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
