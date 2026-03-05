# ============================================
# macro:cmd/storage_get  [base fallback]
# ============================================
# Belirtilen storage yolunun degerini @s'ye gosterir.
# 1.21.6+ overlay bu fonksiyonu hover_event / click_event ile override eder.
# Base version uses a plain tellraw without new event syntax.
#
# BUG FIX v1.0.6-pre1: Bu fonksiyon base'de eksikti.
# Pre-1.21.6 surumlerinde cagrildiginda "Unknown function" hatasına yol aciyordu.
#
# INPUT: macro:input { storage:"<namespace:id>", nbt:"<path>" }
#
# EXAMPLE:
#   data modify storage macro:input storage set value "macro:engine"
#   data modify storage macro:input nbt     set value "players"
#   function macro:cmd/storage_get with storage macro:input {}
# ============================================

$tellraw @s [{"text":"[","color":"dark_gray"},{"text":"$(storage)","color":"gray","italic":true},{"text":"] ","color":"dark_gray"},{"nbt":"$(nbt)","storage":"$(storage)","color":"aqua","italic":false}]
