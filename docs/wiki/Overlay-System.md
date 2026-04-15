# 🔀 Overlay System

← [Home](Home)

---

## What Are Overlays?

Minecraft datapacks support an **overlay** system where version-specific files can override base files. macroEngine uses overlays to support Minecraft versions from 1.20.3 through the latest snapshots in a single ZIP.

```
macroEngine-datapack/
├── pack.mcmeta           ← defines overlays
├── data/                 ← base layer (always loaded)
│   └── macro/
├── 1_20_3/               ← overlay for pack_format 26 only
│   └── data/macro/
├── 1_20_5/               ← overlay for pack_format 41–47
├── _pre_1_21_4/          ← overlay for pack_format 48–61
├── compat_1_21_4/        ← overlay for pack_format 48–61
├── 1_21_5/               ← overlay for pack_format 71
├── 1_21_6/               ← overlay for pack_format 80+
└── 26_1/                 ← overlay for pack_format 101
```

---

## Overlay Map

| Directory | pack_format range | Minecraft version |
|-----------|-------------------|-------------------|
| `1_20_3` | 26 | 1.20.3 – 1.20.4 |
| `1_20_5` | 41 – 47 | 1.20.5 – 1.20.6 |
| `_pre_1_21_4` | 48 – 57 | 1.21.0 – 1.21.3 |
| `compat_1_21_4` | 48 – 61 | 1.21.0 – 1.21.4 |
| `1_21_5` | 71 | 1.21.5 |
| `1_21_6` | 80 – 400000 | 1.21.6+ |
| `26_1` | 101 | 26.1 snapshot |

---

## How Overlays Work

When Minecraft loads the datapack:
1. It reads `pack.mcmeta` and checks which overlays match the current `pack_format`.
2. Matching overlay directories are stacked **on top** of the base `data/` layer.
3. An overlay file shadows its base counterpart — if `1_21_6/data/macro/functions/version.mcfunction` exists, it replaces `data/macro/functions/version.mcfunction` for 1.21.6+.
4. Files only in the base layer are used as-is on all versions.

---

## Why Specific Overlays Exist

| Overlay | Reason |
|---------|--------|
| `1_20_3` | Pre-1.21 item NBT format; different `pack_format`-26-specific command syntax |
| `1_20_5` | Item components introduced; different from both 1.20.3 and 1.21.x formats |
| `_pre_1_21_4` | `hide_tooltip` item component (removed in 1.21.4); legacy `clickEvent` camelCase |
| `compat_1_21_4` | `tooltip_display` replaces `hide_tooltip`; `item_name` JSON object format changes; legacy `clickEvent` |
| `1_21_5` | `click_event` snake_case introduced; `item_name` format further changed |
| `1_21_6` | `dialog` system available; `click_event` + `hover_event` stable |
| `26_1` | Snapshot — experimental feature flags |

---

## Adding Overlay Files

When implementing a fix for a specific version range:

1. Identify which `pack_format` values are affected.
2. Create the file under the matching overlay directory with the same relative path as the base file.
3. Do **not** duplicate the entire base file — only include the lines that differ.
4. Update `pack.mcmeta` if adding a new overlay directory.

```mcfunction
# Base: data/macro/functions/version.mcfunction
# Override for 1.21.5+: 1_21_5/data/macro/functions/version.mcfunction
# The overlay file fully replaces the base for pack_format 71
```

---

## pack.mcmeta Overlay Format

```json
"overlays": {
  "entries": [
    {
      "directory": "1_21_6",
      "formats": { "min_inclusive": 80, "max_inclusive": 400000 },
      "min_format": 80,
      "max_format": 400000
    }
  ]
}
```

> `min_format` / `max_format` (root-level keys on each entry) are required for 1.21.5+ (pack_format ≥ 71) in addition to the `formats` object for backward compatibility.
