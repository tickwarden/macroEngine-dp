# macro:hook/internal/dispatch
# _hook_iter listesini iterate eder, eşleşen event'leri çalıştırır.

execute unless data storage macro:engine _hook_iter[0] run return 0

data modify storage macro:engine _hook_ctx set from storage macro:engine _hook_iter[0]
data remove storage macro:engine _hook_iter[0]

function macro:hook/internal/check_bind with storage macro:engine _hook_ctx

function macro:hook/internal/dispatch
