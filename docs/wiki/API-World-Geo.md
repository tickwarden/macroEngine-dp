# 🌍 World & Geo — `macro:world/*` · `macro:geo/*`

← [Home](Home)

---

## World — `macro:world/*`

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `world/get_time` | — | `{daytime, total, day}` | Current game time |
| `world/block_if` | `{x, y, z, block, invoke}` | — | Run `invoke` if block matches |
| `world/block_unless` | `{x, y, z, block, invoke}` | — | Run `invoke` if block does NOT match |

### Time fields

| Field | Range | Description |
|-------|-------|-------------|
| `daytime` | 0 – 23999 | Current tick within the day |
| `total` | 0 – ∞ | Total world age in ticks |
| `day` | 0 – ∞ | Day count |

```mcfunction
function macro:world/get_time
# output: { daytime: 6000, total: 126000, day: 5 }

# Check daytime (0–12000 = day)
execute if score $daytime macro.time matches ..12000 run say It is daytime
```

---

## Geo — `macro:geo/*`

### Region Checks

| Function | Input | Description |
|----------|-------|-------------|
| `geo/in_region` | `{x1,y1,z1, x2,y2,z2, invoke}` | Run `invoke` if `@s` is inside the region |
| `geo/in_region_unless` | `{x1,y1,z1, x2,y2,z2, invoke}` | Run `invoke` if `@s` is OUTSIDE the region |
| `geo/near_entity` | `{type, radius, invoke}` | Run `invoke` if an entity of `type` is within `radius` |
| `geo/near_entity_unless` | `{type, radius, invoke}` | Run `invoke` if no entity of `type` is within `radius` |

### Persistent Region Watchers — `geo/region_watch/*`

Registers ongoing enter/leave triggers for named rectangular regions. Checked every tick.

| Function | Input | Description |
|----------|-------|-------------|
| `geo/region_watch/register` | `{id, x1,y1,z1, x2,y2,z2, on_enter, on_leave}` | Register a region watcher |
| `geo/region_watch/unregister` | `{id}` | Remove a region watcher |
| `geo/region_watch/list` | — | Show active watchers to `macro.debug` |

---

## Entity — `macro:entity/*`

| Function | Input | Description |
|----------|-------|-------------|
| `entity/spawn` | `{type, x, y, z, tag, nbt}` | Spawn an entity |
| `entity/for_each` | `{type, tag, func}` | Run `func` as each matching entity |
| `entity/for_each_in_radius` | `{player, type, radius, func}` | Run `func` for each matching entity near player |
| `entity/nearest` | `{player, type, radius, func}` | Run `func` as nearest matching entity |
| `entity/clear_effects` | `{type, tag}` | Remove all effects from matching entities |
| `entity/set_health` | `{type, tag, amount}` | Set entity HP via effect chain (1.20.5+ safe) |

---

## NBT Utils — `macro:nbt/*`

| Function | Input | Description |
|----------|-------|-------------|
| `nbt/merge` | `{src_storage, src_path, dst_storage, dst_path}` | Merge compound from src into dst |
| `nbt/first` | `{src_storage, src_path, dst_storage, dst_path}` | Copy first list element to dst |

---

## UUID — `macro:uuid/*`

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `uuid/from_entity` | — (as `@s`) | `macro:input value` | Convert `@s` UUID to hex string |
| `uuid/from_array` | `{arr:[I;…]}` | `macro:input value` | Convert int[4] array to hex string |
| `uuid/store` | `{key, value}` | — | Cache a UUID string |
| `uuid/recall` | `{key}` | `macro:input value` | Retrieve cached UUID string |
| `uuid/recall_array` | `{key}` | `macro:input arr` | Retrieve cached UUID as int[4] |
| `uuid/match` | `{value, func}` | — | Run `func` if `@s` UUID matches `value` |
| `uuid/has` | `{key}` | `result` (1b/0b) | Does cache contain this key? |
| `uuid/forget` | `{key}` | — | Remove single cache entry |
| `uuid/cache_clear` | — | — | Clear entire UUID cache |

---

## Examples

### Region watcher

```mcfunction
data modify storage macro:input id set value "spawn_zone"
data modify storage macro:input x1 set value -50
data modify storage macro:input y1 set value 60
data modify storage macro:input z1 set value -50
data modify storage macro:input x2 set value 50
data modify storage macro:input y2 set value 100
data modify storage macro:input z2 set value 50
data modify storage macro:input on_enter set value "mypack:zone/on_enter_spawn"
data modify storage macro:input on_leave set value "mypack:zone/on_leave_spawn"
function macro:geo/region_watch/register with storage macro:input {}
```

### Track entity by UUID

```mcfunction
# Run as the boss entity, store its UUID
execute as @e[type=minecraft:wither,tag=my_boss,limit=1] run function macro:uuid/from_entity
data modify storage macro:input key set value "my_boss"
data modify storage macro:input value set from storage macro:input value
function macro:uuid/store with storage macro:input {}

# Later: retrieve and target
data modify storage macro:input key set value "my_boss"
function macro:uuid/recall_array with storage macro:input {}
execute as @e[type=minecraft:wither, nbt={UUID:$(arr)}] run say I am the boss
```
