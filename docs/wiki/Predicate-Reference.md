# 🔍 Predicate Reference

← [Home](Home)

Used with `execute if predicate <id>` (run as the target player).

---

## Player State

| Predicate ID | Description |
|---|---|
| `macro:is_survival` | Player is in Survival mode |
| `macro:is_creative` | Player is in Creative mode |
| `macro:is_flying` | Player is flying |
| `macro:is_gliding` | Player is gliding (elytra) |
| `macro:is_sneaking` | Player is sneaking |
| `macro:is_sprinting` | Player is sprinting |
| `macro:is_burning` | Player is on fire |
| `macro:is_on_ground` | Player is on the ground |
| `macro:is_in_water` | Player is in water |
| `macro:is_hungry` | Player is hungry (food < 20) |
| `macro:is_baby` | Entity is a baby |
| `macro:is_full_health` | Player is at full health (20 HP) |

## Inventory

| Predicate ID | Description |
|---|---|
| `macro:has_empty_mainhand` | Player's main hand is empty |
| `macro:has_empty_offhand` | Player's off hand is empty |
| `macro:is_holding_sword` | Player holds any sword in mainhand |
| `macro:is_holding_bow` | Player holds a bow |
| `macro:is_holding_trident` | Player holds a trident |
| `macro:is_holding_shield` | Player holds a shield |

## World

| Predicate ID | Description |
|---|---|
| `macro:is_daytime` | Daytime (0–12000 ticks) |
| `macro:is_raining` | It is raining |
| `macro:is_thundering` | There is a thunderstorm |
| `macro:weather_clear` | Weather is clear |
| `macro:in_overworld` | Player is in the Overworld |
| `macro:in_nether` | Player is in the Nether |
| `macro:in_end` | Player is in the End |
| `macro:health_below_half` | Player's health is below 50% |

---

## Usage Example

```mcfunction
# Only run if sneaking and on the ground
execute as @a if predicate macro:is_sneaking if predicate macro:is_on_ground \
  run function mypack:stealth/enter

# Give bonus only in overworld during daytime
execute as @a if predicate macro:in_overworld if predicate macro:is_daytime \
  run function mypack:daily/sun_bonus
```
