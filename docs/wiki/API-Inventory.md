# 📦 Inventory — `macro:inv/*`

← [Home](Home)

---

## API

| Function | Input | Description |
|----------|-------|-------------|
| `inv/selected_item` | `{item, customData, invoke}` | Run `invoke` for all players holding matching item in mainhand |
| `inv/offhand_item` | `{item, customData, invoke}` | Run `invoke` for all players holding matching item in offhand |
| `inv/player_if_item` | `{player, item, customData, invoke}` | Run `invoke` if specific player holds item in mainhand |
| `inv/player_unless_item` | `{player, item, customData, invoke}` | Run `invoke` if specific player does NOT hold item |
| `inv/player_slot_if_item` | `{player, slot, item, customData, invoke}` | Run `invoke` if specific slot contains item |
| `inv/chest_minecart_if_item` | `{item, customData, invoke}` | Run `invoke` for chests/minecarts containing item |
| `inv/chest_minecart_unless_item` | `{item, customData, invoke}` | Run `invoke` for containers NOT containing item |
| `inv/cursor_item` | — | Read cursor item (held in GUI) to `macro:output` |

---

## Parameters

| Field | Type | Description |
|-------|------|-------------|
| `item` | string | Item ID, e.g. `"minecraft:diamond_sword"` |
| `customData` | compound | `minecraft:custom_data` NBT to match (optional) |
| `invoke` | string | Function path to call on match |

---

## Examples

### Detect mainhand item for all players

```mcfunction
data modify storage macro:input item set value "minecraft:carrot_on_a_stick"
data modify storage macro:input customData set value {mypack_tag:"my_wand"}
data modify storage macro:input invoke set value "mypack:wand/on_hold"
function macro:inv/selected_item with storage macro:input {}
```

### Check specific player's slot

```mcfunction
# Check if Steve has a diamond in slot 0 (first hotbar slot)
data modify storage macro:input player set value "Steve"
data modify storage macro:input slot set value 0
data modify storage macro:input item set value "minecraft:diamond"
data modify storage macro:input customData set value {}
data modify storage macro:input invoke set value "mypack:diamond/found"
function macro:inv/player_slot_if_item with storage macro:input {}
```

### Check chest contents

```mcfunction
# Run function for each chest containing a beacon
data modify storage macro:input item set value "minecraft:beacon"
data modify storage macro:input customData set value {}
data modify storage macro:input invoke set value "mypack:chest/found_beacon"
function macro:inv/chest_minecart_if_item with storage macro:input {}
```

---

## Notes

- `customData` uses `minecraft:custom_data` component matching (1.21.x+). Pass `{}` to match any item of the given type regardless of custom data.
- `invoke` (previously `action` / `callback` in older versions) — always use `invoke` in v2.0.3+.
- `inv/cursor_item` reads from the player's GUI cursor slot and writes to `macro:output`. Useful in combination with `interaction/` for custom UIs.
