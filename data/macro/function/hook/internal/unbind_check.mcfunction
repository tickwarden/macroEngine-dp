# macro:hook/internal/unbind_check [MACRO]
# INPUT: $(event) — mevcut bind'ın event field'ı
# _hook_filter_event ile eşleşmiyorsa hook_binds'e geri koy.

$execute unless data storage macro:engine {_hook_filter_event:"$(event)"} run data modify storage macro:engine hook_binds append from storage macro:engine _hook_unbinds[0]
