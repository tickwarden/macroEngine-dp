advancement grant @a only macro:hidden/root

forceload add -30000000 1600

execute unless function ame_load:load/internal/validate run return 0

data modify storage macro:input level set value "A.M.E."
data modify storage macro:input message set value "Starting..."
data modify storage macro:input color set value "aqua"
function macro:log/add with storage macro:input {}

function ame_load:load/scoreboards

function ame_load:load/storages

function ame_load:load/other

data modify storage macro:engine global.loaded set value 1b

function ame_load:load/internal/version_set

tellraw @a[tag=macro.debug] {"text":"[Macro Engine v2.0.3-pre3] Loaded.","color":"green"}
data modify storage macro:input sound set value "minecraft:ui.toast.challenge_complete"
data modify storage macro:input volume set value 1
data modify storage macro:input pitch set value 1
execute if entity @a[advancements={macro:hidden/root=true}] run function macro:cmd/sound_all with storage macro:input {}
data remove storage macro:input sound
data remove storage macro:input volume
data remove storage macro:input pitch

data modify storage macro:input level set value "Advanced Macro Engine v2.0.3-pre3"
data modify storage macro:input message set value "Loaded."
data modify storage macro:input color set value "green"
execute if entity @a[advancements={macro:hidden/root=true}] run function macro:log/add with storage macro:input {}

function ame_load:load/internal/finalize
