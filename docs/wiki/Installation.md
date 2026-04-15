# 📦 Installation

← [Home](Home)

---

## Requirements

| Requirement | Details |
|-------------|---------|
| Minecraft | Java Edition 1.20.3 or newer |
| Server type | Vanilla, Paper, Fabric (vanilla commands only — no mod APIs used) |
| Operator level | OP level 2+ required to run admin functions |

---

## Standard Installation

### 1. Download

Download the latest release ZIP from the [Releases page](https://github.com/tickwarden/macroEngine-datapack/releases).

> ⚠️ **Only download from the official Releases page.** Third-party mirrors may contain modified files.

### 2. Verify SHA256 (recommended)

```bash
# Windows
certutil -hashfile macroEngine-datapack.zip SHA256

# Linux / macOS
sha256sum macroEngine-datapack.zip
```

Compare the output against the SHA256 listed on the release page.

### 3. Place the datapack

```
server/
└── world/
    └── datapacks/
        └── macroEngine-datapack/   ← extract ZIP here (or place ZIP directly)
```

> The ZIP root must contain `pack.mcmeta` and `data/` directly — no extra subfolder.

### 4. Reload

```
/reload
```

You will see a confirmation message in chat (or in the server log if no players are online).

### 5. Confirm load

When prompted (if `ame_load:load/confirm` fires), run:

```
/function ame_load:load/yes
```

> The confirmation gate prevents accidental overwrites of existing session data on `/reload`.

### 6. Grant admin

```
/tag @s add macro.admin
```

---

## Multiple Datapacks (LanternLoad)

If your server uses other LanternLoad-compatible datapacks, macroEngine integrates automatically. Version detection:

```mcfunction
# Check if macroEngine is loaded
execute if score macroEngine load.status matches 1.. run say loaded

# Get version (major*10000 + minor*100 + patch)
# v4.0.0 = 40000
scoreboard players get macroEngine load.status
```

---

## Disabling

To fully disable macroEngine and clean all scoreboards/storage:

```
/function macro:disable/main
```

---

## Supported Minecraft Versions

| Minecraft Version | pack_format | Overlay |
|-------------------|-------------|---------|
| 1.20.3 – 1.20.4 | 26 | `1_20_3` |
| 1.20.5 – 1.20.6 | 41–47 | `1_20_5` |
| 1.21.0 – 1.21.3 | 48–57 | `_pre_1_21_4` + `compat_1_21_4` |
| 1.21.4 | 61 | `compat_1_21_4` |
| 1.21.5 | 71 | `1_21_5` |
| 1.21.x (late) | 80–94 | base |
| 1.21.6+ | 80+ | `1_21_6` |
| 26.1 snapshot | 101 | `26_1` |

The correct overlay is selected automatically — no manual configuration needed.
