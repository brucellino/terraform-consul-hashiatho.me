# variables.tf
variable "consul_http_addr" {
  default     = "http://bare:8500"
  description = "Consul HTTP Address"
  sensitive   = false
  type        = string
}
