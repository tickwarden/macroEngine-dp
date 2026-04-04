#!/usr/bin/env python3
"""
pack.mcmeta düzenleyici.
Kullanım: edit_pack_mcmeta.py <pack_format> <supported_min> <supported_max> [overlay_file]
  overlay_file: her satır "<directory>=<min>:<max>" formatında
"""

import json
import sys


def main():
    if len(sys.argv) < 4:
        print("Kullanım: edit_pack_mcmeta.py <pack_format> <supported_min> <supported_max> [overlay_file]")
        sys.exit(1)

    pf   = int(sys.argv[1])
    smin = int(sys.argv[2])
    smax = int(sys.argv[3])
    overlay_file = sys.argv[4] if len(sys.argv) > 4 else None

    overlay_raw = ""
    if overlay_file:
        with open(overlay_file, "r", encoding="utf-8") as f:
            overlay_raw = f.read().strip()

    with open("pack.mcmeta", "r", encoding="utf-8") as f:
        meta = json.load(f)

    old_pf   = meta["pack"]["pack_format"]
    old_smin = meta["pack"].get("supported_formats", {}).get("min_inclusive", "?")
    old_smax = meta["pack"].get("supported_formats", {}).get("max_inclusive", "?")

    meta["pack"]["pack_format"] = pf
    meta["pack"]["supported_formats"] = {
        "min_inclusive": smin,
        "max_inclusive": smax,
    }

    if "min_format" in meta["pack"]:
        meta["pack"]["min_format"] = smin
    if "max_format" in meta["pack"]:
        meta["pack"]["max_format"] = smax

    print(f"pack_format      : {old_pf} → {pf}")
    print(f"supported_formats: [{old_smin}, {old_smax}] → [{smin}, {smax}]")

    if overlay_raw:
        entries = {e["directory"]: e for e in meta.get("overlays", {}).get("entries", [])}
        for line in overlay_raw.splitlines():
            line = line.strip()
            if not line or "=" not in line or ":" not in line:
                continue
            directory, fmt = line.split("=", 1)
            directory = directory.strip()
            o_min, o_max = fmt.strip().split(":", 1)
            o_min, o_max = int(o_min), int(o_max)

            if directory in entries:
                old_fmt = entries[directory].get("formats", {})
                old_min = old_fmt.get("min_inclusive", "?")
                old_max = old_fmt.get("max_inclusive", "?")
                entries[directory]["formats"] = {
                    "min_inclusive": o_min,
                    "max_inclusive": o_max,
                }
                if "min_format" in entries[directory]:
                    entries[directory]["min_format"] = o_min
                if "max_format" in entries[directory]:
                    entries[directory]["max_format"] = o_max
                print(f"overlay '{directory}': [{old_min}, {old_max}] → [{o_min}, {o_max}]")
            else:
                print(f"WARN: overlay '{directory}' pack.mcmeta'da bulunamadı, atlandı.")

    with open("pack.mcmeta", "w", encoding="utf-8") as f:
        json.dump(meta, f, indent=2, ensure_ascii=False)
        f.write("\n")

    print("pack.mcmeta güncellendi.")


if __name__ == "__main__":
    main()
