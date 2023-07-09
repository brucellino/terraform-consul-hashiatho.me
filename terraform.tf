terraform {
  required_version = ">= 1.5"
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.16.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.17.0"
    }
  }
}
