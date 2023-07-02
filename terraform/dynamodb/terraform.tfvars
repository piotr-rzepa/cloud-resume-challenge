billing_mode   = "PROVISIONED"
read_capacity  = 1
write_capacity = 1
attributes_list = [{
  name = "CounterName"
  type = "S"
}]
hash_key = "CounterName"
