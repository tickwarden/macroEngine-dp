# 🔧 Advanced Macro Engine — Wiki

**Minecraft Java Edition 1.20.3 – 1.21.6+ | Multiplayer-Safe | Pure Datapack**

> Current version: **v4.0.0** · Repository: [tickwarden/macroEngine-datapack](https://github.com/tickwarden/macroEngine-datapack)

---

## 📚 Pages

### Getting Started
| Page | Description |
|------|-------------|
| [Installation](Installation) | How to install and configure the datapack |
| [Storage Architecture](Storage-Architecture) | `macro:engine`, `macro:input`, `macro:output` layout |
| [Overlay System](Overlay-System) | Multi-version overlay structure (`1_20_3`, `1_21_5`, etc.) |
| [Admin Guide](Admin-Guide) | `macro.admin` tag, permission system, debug tools |

### API Reference
| Module | Page |
|--------|------|
| 🕐 Cooldown | [API-Cooldown](API-Cooldown) |
| 📡 Event | [API-Event](API-Event) |
| 🔢 Math | [API-Math](API-Math) |
| 🔤 String | [API-String](API-String) |
| 👤 Player | [API-Player](API-Player) |
| 🔁 Library | [API-Library](API-Library) |
| 🎣 Hook | [API-Hook](API-Hook) |
| 🖱️ Interaction | [API-Interaction](API-Interaction) |
| 🔒 Permission | [API-Permission](API-Permission) |
| 🪄 Wand | [API-Wand](API-Wand) |
| 🏳️ Flag & State | [API-Flag-State](API-Flag-State) |
| 🌍 World & Geo | [API-World-Geo](API-World-Geo) |
| 📦 Inventory | [API-Inventory](API-Inventory) |
| 💬 Dialog | [API-Dialog](API-Dialog) |

### Reference
| Page | Description |
|------|-------------|
| [Predicate Reference](Predicate-Reference) | All built-in predicates |
| [Scoreboard Reference](Scoreboard-Reference) | All objectives and fake players |
| [Changelog](Changelog) | Full version history |
| [Migration Guide](Migration-Guide) | Migrating from `ToolkitMC/macroEngine-dp` |

---

## ⚡ Quick Start

```mcfunction
# 1. Install the datapack (see Installation page)
# 2. Reload
/reload

# 3. Grant yourself admin
/tag @s add macro.admin

# 4. Call your first API function
/function macro:cooldown/set {player:"Steve", key:"fireball", duration:100}
```

---

## 🔑 Key Concepts

**Storage-based API** — All functions communicate through three storage namespaces:
- `macro:input` — send arguments to a function
- `macro:output` — receive results from a function  
- `macro:engine` — persistent engine state (players, cooldowns, events, etc.)

**Macro injection** — Lines starting with `$` and containing `$(var)` receive substituted values at runtime.

**Overlays** — Version-specific overrides stacked on top of the base layer. The correct overlay is selected automatically by `pack_format`.

**LanternLoad** — Deterministic load order managed by the `load.status` scoreboard.
