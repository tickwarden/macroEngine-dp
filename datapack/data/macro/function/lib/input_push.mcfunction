# ============================================
# macro:lib/input_push
# ============================================
# macro:input'in mevcut durumunu bir stack'e kaydeder.
# Fonksiyon içinden başka bir fonksiyon çağırmadan önce
# input'u korumak için kullanın. Ardından input_pop çağırın.
#
# v3.1: Tüm cmd alanları dahil — ses, parçacık, varlık,
# başlık, efekt, bossbar, gamerule, tp vb.
# ============================================

data modify storage macro:engine _input_stack append value {}

# ─── Temel alanlar ───────────────────────────────────────
data modify storage macro:engine _input_stack[-1].player set from storage macro:input player
data modify storage macro:engine _input_stack[-1].key set from storage macro:input key
data modify storage macro:engine _input_stack[-1].value set from storage macro:input value
data modify storage macro:engine _input_stack[-1].func set from storage macro:input func
data modify storage macro:engine _input_stack[-1].count set from storage macro:input count
data modify storage macro:engine _input_stack[-1].delay set from storage macro:input delay
data modify storage macro:engine _input_stack[-1].event set from storage macro:input event
data modify storage macro:engine _input_stack[-1].duration set from storage macro:input duration
data modify storage macro:engine _input_stack[-1].team set from storage macro:input team
data modify storage macro:engine _input_stack[-1].target set from storage macro:input target
data modify storage macro:engine _input_stack[-1].message set from storage macro:input message
data modify storage macro:engine _input_stack[-1].color set from storage macro:input color
data modify storage macro:engine _input_stack[-1].label set from storage macro:input label
data modify storage macro:engine _input_stack[-1].interval set from storage macro:input interval
data modify storage macro:engine _input_stack[-1].amount set from storage macro:input amount
data modify storage macro:engine _input_stack[-1].objective set from storage macro:input objective
data modify storage macro:engine _input_stack[-1].item set from storage macro:input item
data modify storage macro:engine _input_stack[-1].tag set from storage macro:input tag
data modify storage macro:engine _input_stack[-1].a set from storage macro:input a
data modify storage macro:engine _input_stack[-1].b set from storage macro:input b
data modify storage macro:engine _input_stack[-1].t set from storage macro:input t
data modify storage macro:engine _input_stack[-1].min set from storage macro:input min
data modify storage macro:engine _input_stack[-1].max set from storage macro:input max
data modify storage macro:engine _input_stack[-1].n set from storage macro:input n
# ─── Koordinat alanları (fill/setblock/summon/tp/particle) ─
data modify storage macro:engine _input_stack[-1].x set from storage macro:input x
data modify storage macro:engine _input_stack[-1].y set from storage macro:input y
data modify storage macro:engine _input_stack[-1].z set from storage macro:input z
data modify storage macro:engine _input_stack[-1].x1 set from storage macro:input x1
data modify storage macro:engine _input_stack[-1].y1 set from storage macro:input y1
data modify storage macro:engine _input_stack[-1].z1 set from storage macro:input z1
data modify storage macro:engine _input_stack[-1].x2 set from storage macro:input x2
data modify storage macro:engine _input_stack[-1].y2 set from storage macro:input y2
data modify storage macro:engine _input_stack[-1].z2 set from storage macro:input z2
# ─── Parçacık (particle) ─────────────────────────────────
data modify storage macro:engine _input_stack[-1].name set from storage macro:input name
data modify storage macro:engine _input_stack[-1].dx set from storage macro:input dx
data modify storage macro:engine _input_stack[-1].dy set from storage macro:input dy
data modify storage macro:engine _input_stack[-1].dz set from storage macro:input dz
data modify storage macro:engine _input_stack[-1].speed set from storage macro:input speed
# ─── Ses (sound/stopsound) ───────────────────────────────
data modify storage macro:engine _input_stack[-1].sound set from storage macro:input sound
data modify storage macro:engine _input_stack[-1].volume set from storage macro:input volume
data modify storage macro:engine _input_stack[-1].pitch set from storage macro:input pitch
data modify storage macro:engine _input_stack[-1].source set from storage macro:input source
data modify storage macro:engine _input_stack[-1].category set from storage macro:input category
# ─── Varlık/Blok (summon/setblock) ───────────────────────
data modify storage macro:engine _input_stack[-1].entity set from storage macro:input entity
data modify storage macro:engine _input_stack[-1].nbt set from storage macro:input nbt
data modify storage macro:engine _input_stack[-1].block set from storage macro:input block
data modify storage macro:engine _input_stack[-1].mode set from storage macro:input mode
# ─── UI (title/actionbar/subtitle) ───────────────────────
data modify storage macro:engine _input_stack[-1].text set from storage macro:input text
data modify storage macro:engine _input_stack[-1].title set from storage macro:input title
data modify storage macro:engine _input_stack[-1].subtitle set from storage macro:input subtitle
data modify storage macro:engine _input_stack[-1].fade_in set from storage macro:input fade_in
data modify storage macro:engine _input_stack[-1].stay set from storage macro:input stay
data modify storage macro:engine _input_stack[-1].fade_out set from storage macro:input fade_out
# ─── Efekt/Büyü/Attribute ────────────────────────────────
data modify storage macro:engine _input_stack[-1].effect set from storage macro:input effect
data modify storage macro:engine _input_stack[-1].enchantment set from storage macro:input enchantment
data modify storage macro:engine _input_stack[-1].level set from storage macro:input level
data modify storage macro:engine _input_stack[-1].attribute set from storage macro:input attribute
data modify storage macro:engine _input_stack[-1].amplifier set from storage macro:input amplifier
# ─── Bossbar ─────────────────────────────────────────────
data modify storage macro:engine _input_stack[-1].id set from storage macro:input id
# ─── Diğer komutlar ──────────────────────────────────────
data modify storage macro:engine _input_stack[-1].rule set from storage macro:input rule
data modify storage macro:engine _input_stack[-1].type set from storage macro:input type
data modify storage macro:engine _input_stack[-1].structure set from storage macro:input structure
data modify storage macro:engine _input_stack[-1].loot_table set from storage macro:input loot_table
data modify storage macro:engine _input_stack[-1].reason set from storage macro:input reason
data modify storage macro:engine _input_stack[-1].cmd set from storage macro:input cmd
# ─── Spreadplayers ───────────────────────────────────────
data modify storage macro:engine _input_stack[-1].cx set from storage macro:input cx
data modify storage macro:engine _input_stack[-1].cz set from storage macro:input cz
data modify storage macro:engine _input_stack[-1].spread set from storage macro:input spread
data modify storage macro:engine _input_stack[-1].max_range set from storage macro:input max_range
