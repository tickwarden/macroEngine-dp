# 🔧 Advanced Macro Engine — v2.0.3-pre1
**Minecraft Java Edition 1.21.x | Multiplayer-Safe | Pure Datapack**

---

## ✅ Doğrulama

> ⚠️ **Bu, TEK resmi kaynaktır.**  
> Başka sitelerden veya fork'lardan indirilen dosyalar değiştirilmiş olabilir.  
> Yalnızca [Releases](https://github.com/tickwarden/macroEngine-dp/releases) sayfasından indirin.

**SHA256:** `sha256:f99aecf13b35ad672525f6ca339a0579cce50913fdbd0022deb75a3634e34061`

```bash
# Windows
certutil -hashfile datapack.zip SHA256

# Linux / Mac
sha256sum datapack.zip
```

---

## 📦 Kurulum

```
1. advanced_macro_engine_v30/ → sunucu/datapacks/ klasörüne koy
2. /reload
3. Admin olun: /tag @s add macro.admin
```

---

## 🏗️ Storage Mimarisi

```
macro:engine  (kalıcı veri)
├── global
│   ├── version: "v2.0.3-pre1"
│   └── tick: <int>
├── players
│   └── Steve { coins:150, level:5, xp:2300, online:1b, ... }
├── queue
│   └── [{func:"mypack:event/end", delay:100}]
├── cooldowns
│   └── Steve { fireball: 2460, dash: 1870 }  ← expiry tick'leri
└── events
    └── on_join: [{func:"mypack:welcome"}, {func:"mypack:xp_bonus"}]

macro:input   (fonksiyona veri gönderme)
macro:output  (fonksiyondan sonuç alma)
```

---

## 🔍 Predicate Sistemi — `macro:predicate/*`

`execute if predicate <id>` komutuyla kullanılır.

| Predicate ID | Açıklama |
|---|---|
| `macro:is_survival` | Oyuncu survival modda mı? |
| `macro:is_creative` | Oyuncu creative modda mı? |
| `macro:has_empty_mainhand` | Ana eldeki eşya boş mu? |
| `macro:is_full_health` | Oyuncu tam canda mı? (20 HP) |
| `macro:is_sneaking` | Oyuncu sinsi mi? |
| `macro:is_sprinting` | Oyuncu koşuyor mu? |
| `macro:is_burning` | Oyuncu yanıyor mu? |
| `macro:is_on_ground` | Oyuncu yerde mi? |
| `macro:is_daytime` | Gündüz mü? (0–12000 tick) |
| `macro:is_raining` | Yağmur yağıyor mu? |
| `macro:is_thundering` | Gök gürültülü fırtına mı? |
| `macro:in_overworld` | Üst dünya mı? |
| `macro:in_nether` | Nether mi? |
| `macro:in_end` | End mi? |

---

## 📚 API Referansı & Örnekler

Kodlar ve örnekler modüllere göre ayrı dokümanlarda:

| Modül | Döküman |
|-------|---------|
| 🕐 Cooldown | [cooldown.md](cooldown.md) |
| 📡 Event | [event.md](event.md) |
| 🔢 Matematik | [math.md](math.md) |
| 👥 Takım & ⚙️ Config | [team-config.md](team-config.md) |
| 🔁 Lib · 👤 Oyuncu · ⚙️ Komutlar · 💬 Mesajlaşma | [lib-player-cmd-string.md](lib-player-cmd-string.md) |

---

## 🩹 Değişiklik Geçmişi

### v3.0 — Bug Fix & Yeni Modüller

| Bug | Dosya | Düzeltme |
|-----|-------|---------|
| **KRİTİK**: `/reload`'da `$epoch` sıfırlanıyordu | `load.mcfunction` | `unless score $epoch` guard'ı eklendi |
| `process_queue` stack overflow riski | `lib/process_queue` | `$pq_depth` ile tick başına 256 limit |
| Version string tutarsızlığı | `load`, `pack.mcmeta` | Tüm referanslar v3.0 olarak güncellendi |

**Yeni modüller:** `math/abs`, `math/clamp`, `team/*`, `config/*`, `lib/input_push`, `lib/input_pop`

### v2.4 — Bug Fix

| Bug | Dosya | Düzeltme |
|-----|-------|---------|
| **KRİTİK**: Cooldown'lar hiç dolmuyordu | `cooldown/*` | `$epoch macro.time` (mutlak sayaç) kullanıldı |
| `progress_bar` ham sayı gösteriyordu | `string/progress_bar` | `█░` lookup tablosu eklendi |
| `fire_next` NBT predicate yanlıştı | `event/internal/fire_next` | `event_queue[0]` path kontrolü |
| `ceil_div` prefix çakışması | `math/ceil_div` | `$cd_1` → `$cdv_1` |

### v2.3 — Yeni Sistemler

`cooldown/`, `event/`, `lib/`, `math/`, `cmd/`, `string/`, `player/` modülleri eklendi.

### v2.2 — Bug Fix

| Bug | Düzeltme |
|-----|----------|
| `data remove storage macro:input {}` geçersiz | `data modify ... set value {}` |
| subtitle rengi hardcoded `"gray"` | `"color":"$(color)"` dinamik |

---

## 💬 Topluluk & Destek

[![Discussions](https://img.shields.io/github/discussions/tickwarden/macroEngine-dp?style=for-the-badge&logo=github&color=blue)](https://github.com/tickwarden/macroEngine-dp/discussions)

[GitHub Discussions](https://github.com/tickwarden/macroEngine-dp/discussions) — Soru, öneri ve hata bildirimleri için.

---

*Advanced Macro Engine v3.0 | MC Java 1.21.x | Dil: mcfunction*
