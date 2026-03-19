# macro:hook/internal/unbind_filter
# _hook_unbinds listesini iterate eder.
# _hook_filter_event ile eşleşmeyen bind'ları hook_binds'e geri kopyalar.

execute unless data storage macro:engine _hook_unbinds[0] run return 0

data modify storage macro:engine _hook_unbinds[0] set from storage macro:engine _hook_unbinds[0]

function macro:hook/internal/unbind_check with storage macro:engine _hook_unbinds[0]

data remove storage macro:engine _hook_unbinds[0]

function macro:hook/internal/unbind_filter
