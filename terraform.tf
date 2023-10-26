terraform {
  required_version = ">= 1.5"
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.19.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.21.0"
    }
  }
}
