terraform {
  required_version = ">= 1.5"
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.20.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0.0"
    }
  }
}
