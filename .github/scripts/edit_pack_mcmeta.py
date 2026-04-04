#!/usr/bin/env python3

import json
import os
import sys
from typing import Dict, Any


def main() -> None:
    if len(sys.argv) < 4:
        print("Kullanım: edit_pack_mcmeta.py <pack_format> <supported_min> <supported_max>")
        sys.exit(1)

    try:
        pf = int(sys.argv[1])
        smin = int(sys.argv[2])
        smax = int(sys.argv[3])
    except ValueError:
        print("Hata: pack_format, supported_min ve supported_max tam sayı olmalıdır.")
        sys.exit(1)

    # GitHub Actions'tan overlay_updates girdisini oku
    overlay_raw = ""
    event_path = os.environ.get("GITHUB_EVENT_PATH", "")
    if event_path and os.path.exists(event_path):
        try:
            with open(event_path, "r", encoding="utf-8") as f:
                event = json.load(f)
            overlay_raw = event.get("inputs", {}).get("overlay_updates", "") or ""
        except (json.JSONDecodeError, IOError) as e:
            print(f"Uyarı: GitHub event dosyası okunamadı: {e}")

    # pack.mcmeta dosyasını oku
    try:
        with open("pack.mcmeta", "r", encoding="utf-8") as f:
            meta: Dict[str, Any] = json.load(f)
    except FileNotFoundError:
        print("Hata: pack.mcmeta dosyası bulunamadı!")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Hata: pack.mcmeta geçerli bir JSON değil: {e}")
        sys.exit(1)

    pack = meta.setdefault("pack", {})

    # Eski değerleri kaydet (log için)
    old_pf = pack.get("pack_format")
    supported = pack.get("supported_formats", {})
    old_smin = supported.get("min_inclusive", "?")
    old_smax = supported.get("max_inclusive", "?")

    # Ana pack_format ve supported_formats güncelle
    pack["pack_format"] = pf
    pack["supported_formats"] = {
        "min_inclusive": smin,
        "max_inclusive": smax,
    }

    # Eski stil min_format / max_format varsa onları da güncelle (geriye uyumluluk)
    if "min_format" in pack:
        pack["min_format"] = smin
    if "max_format" in pack:
        pack["max_format"] = smax

    print(f"pack_format : {old_pf} → {pf}")
    print(f"supported_formats: [{old_smin}, {old_smax}] → [{smin}, {smax}]")

    # Overlay'leri güncelle (varsa)
    if overlay_raw.strip():
        entries: Dict[str, Dict[str, Any]] = {
            e["directory"]: e
            for e in meta.get("overlays", {}).get("entries", [])
        }

        for line in overlay_raw.splitlines():
            line = line.strip()
            if not line or "=" not in line or ":" not in line:
                continue

            try:
                directory, fmt = [x.strip() for x in line.split("=", 1)]
                o_min_str, o_max_str = [x.strip() for x in fmt.split(":", 1)]

                o_min = int(o_min_str)
                o_max = int(o_max_str)

                if directory in entries:
                    entry = entries[directory]
                    old_fmt = entry.get("formats", {})
                    old_min = old_fmt.get("min_inclusive", "?")
                    old_max = old_fmt.get("max_inclusive", "?")

                    entry["formats"] = {
                        "min_inclusive": o_min,
                        "max_inclusive": o_max,
                    }

                    if "min_format" in entry:
                        entry["min_format"] = o_min
                    if "max_format" in entry:
                        entry["max_format"] = o_max

                    print(f"overlay '{directory}': [{old_min}, {old_max}] → [{o_min}, {o_max}]")
                else:
                    print(f"WARN: overlay '{directory}' pack.mcmeta'da bulunamadı, atlandı.")

            except (ValueError, IndexError) as e:
                print(f"WARN: Geçersiz overlay satırı atlandı: '{line}' ({e})")

    # Güncellenmiş pack.mcmeta'yı yaz
    try:
        with open("pack.mcmeta", "w", encoding="utf-8") as f:
            json.dump(meta, f, indent=2, ensure_ascii=False)
            f.write("\n")
        print("✅ pack.mcmeta başarıyla güncellendi.")
    except IOError as e:
        print(f"Hata: pack.mcmeta yazılamadı: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
