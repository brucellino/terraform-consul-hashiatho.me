terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.16.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.10.0"
    }
  }
  backend "consul" {
    scheme = "http"
    path   = "hashiatho.me/consul/tfstate"
  }
}
