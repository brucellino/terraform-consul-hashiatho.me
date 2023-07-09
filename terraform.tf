terraform {
  required_version = ">= 1.5"
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.17.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.10.0"
    }
  }
}
