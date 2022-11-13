# Allow all nodes to write data
node_prefix "" {
  policy = "write"
}

# Allow all services to read data
service_prefix "" {
  policy = "read"
}
