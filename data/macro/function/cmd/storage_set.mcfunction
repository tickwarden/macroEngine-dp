# macro:cmd/storage_set — Write data to storage
# INPUT: macro:input { storage:"<storage_id>", nbt:"<path>", actionType:"value|from|...", value:<value> }
# EXAMPLE (value write):
#   data modify storage macro:input storage set value "macro:engine"
#   data modify storage macro:input nbt set value "config.debug"
#   data modify storage macro:input actionType set value "value"
#   data modify storage macro:input value set value 1b
#   function macro:cmd/storage_set with storage macro:input {}
$data modify storage $(storage) $(nbt) set $(actionType) $(value)
