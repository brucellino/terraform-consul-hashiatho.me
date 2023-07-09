provider "consul" {}

provider "vault" {}


terraform {
  backend "consul" {
    path = "terraform/modules/hah/simple"
  }
}


module "example" {
  source = "../../"
}
