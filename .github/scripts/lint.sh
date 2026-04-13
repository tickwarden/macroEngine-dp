#!/usr/bin/env bash
# =============================================================================
# AME mcfunction Linter - Stabil & Esnek Versiyon
# =============================================================================
set -euo pipefail

# Renk tanımları
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Overlay dizinleri
MC_DIRS=(
  data
  _pre_1_21_4
  compat_1_21_4
  1_20_3
  1_20_5
  1_21_5
  1_21_6
)

# Sayaçlar
TOTAL_ERRORS=0
TOTAL_WARNS=0
TOTAL_PASSED=0

# Yardımcı fonksiyonlar
find_mcfunction() {
  find "${MC_DIRS[@]}" -name "*.mcfunction" -print0 2>/dev/null
}

find_json() {
  find "${MC_DIRS[@]}" -name "*.json" -print0 2>/dev/null
}

print_header() {
  echo ""
  echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
  echo -e "${BOLD}${CYAN} $1${RESET}"
  echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
}

pass() {
  echo -e " ${GREEN}✔ PASSED:${RESET} $1"
  TOTAL_PASSED=$((TOTAL_PASSED + 1))
}

warn() {
  echo -e " ${YELLOW}⚠ WARN:${RESET} $1"
  TOTAL_WARNS=$((TOTAL_WARNS + 1))
}

fail() {
  echo -e " ${RED}✖ FAIL:${RESET} $1"
  TOTAL_ERRORS=$((TOTAL_ERRORS + 1))
}

detail() {
  echo -e " ${YELLOW}→${RESET} $1"
}

# 1. CRLF
check_crlf() {
  print_header "1. CRLF Line Ending Check"
  local found=0
  while IFS= read -r -d '' f; do
    if file "$f" | grep -q "CRLF"; then
      fail "[CRLF] $f"
      detail "Fix: dos2unix $f"
      found=$((found + 1))
    fi
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No CRLF line endings found."
}

# 2. Macro Line Prefix (Stabil)
check_macro_prefix() {
  print_header "2. Macro Line Prefix Check"
  local found=0
  while IFS= read -r -d '' f; do
    [[ -z "$f" ]] && continue
    mapfile -t bad < <(grep -nP '\$\([a-zA-Z_]\w*\)' "$f" 2>/dev/null)
    for lineinfo in "${bad[@]}"; do
      local lineno=${lineinfo%%:*}
      local content=${lineinfo#*:}
      local code=${content%%#*}
      local stripped=${code#"${code%%[![:space:]]*}"}
      [[ -z "$stripped" ]] && continue
      if ! echo "$content" | grep -qP '^\s*\$'; then
        fail "[macro-prefix] $f:$lineno"
        detail "$content"
        found=$((found + 1))
      fi
    done
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "All macro variables are on lines starting with \$" || detail "$found error(s)"
}

# 3. Useless Dollar Prefix (DÜZELTİLDİ)
check_useless_dollar() {
  print_header "3. Useless Dollar Prefix Check"
  local found=0
  while IFS= read -r -d '' f; do
    [[ -z "$f" ]] && continue
    mapfile -t lines < <(grep -nP '^\s*\$' "$f" 2>/dev/null)
    for lineinfo in "${lines[@]}"; do
      local lineno=${lineinfo%%:*}
      local line=${lineinfo#*:}
      local stripped="${line#"${line%%[![:space:]]*}"}"
      if [[ "$stripped" == \$* ]] && ! echo "$stripped" | grep -qP '\$\([a-zA-Z_]\w*\)'; then
        warn "[useless-\$] $f:$lineno"
        detail "$line"
        found=$((found + 1))
      fi
    done
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No useless dollar prefixes found." || detail "$found useless \$ found."
}

# 4. INPUT Comment
check_input_comment() {
  print_header "4. INPUT Comment Coverage"
  local found=0
  while IFS= read -r -d '' f; do
    if grep -qP '^\$' "$f" && ! grep -qP '^# INPUT:' "$f"; then
      warn "[no-input-comment] $f"
      found=$((found + 1))
    fi
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "All macro files have INPUT comments." || detail "$found file(s) missing INPUT comment."
}

# 5. @p Selector
check_at_p() {
  print_header "5. @p Selector Check"
  local found=0
  while IFS= read -r -d '' f; do
    mapfile -t bad < <(grep -nP '@p\b' "$f" 2>/dev/null)
    for lineinfo in "${bad[@]}"; do
      local lineno=${lineinfo%%:*}
      local line=${lineinfo#*:}
      warn "[@p] $f:$lineno"
      detail "$line"
      found=$((found + 1))
    done
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No @p usage found." || detail "Prefer: @a[name=\$(player),limit=1]"
}

# 6. Trailing Whitespace
check_trailing_whitespace() {
  print_header "6. Trailing Whitespace Check"
  local found=0
  while IFS= read -r -d '' f; do
    local count=$(grep -cP '\s+$' "$f" || echo 0)
    if [ "$count" -gt 0 ]; then
      warn "[trailing-ws] $f ($count line(s))"
      found=$((found + count))
    fi
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No trailing whitespace found." || detail "$found total trailing whitespace line(s)."
}

# 7. JSON Validation
check_json() {
  print_header "7. JSON Validation"
  local found=0
  while IFS= read -r -d '' f; do
    if ! jq empty "$f" >/dev/null 2>&1; then
      fail "[invalid-json] $f"
      found=$((found + 1))
    fi
  done < <(find_json)
  [ $found -eq 0 ] && pass "All JSON files are valid."
}

# 8-14 arası check'ler (kısaltılmış ama stabil)
check_deprecated_text() {
  print_header "8. Deprecated Text Component Keys"
  local found=0
  while IFS= read -r -d '' f; do
    mapfile -t bad < <(grep -nP '"(clickEvent|hoverEvent)"' "$f" 2>/dev/null)
    for lineinfo in "${bad[@]}"; do
      warn "[deprecated-key] $f:${lineinfo%%:*}"
      detail "${lineinfo#*:}"
      found=$((found + 1))
    done
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No deprecated text component keys." || detail "Use click_event / hover_event"
}

check_hardcoded_names() {
  print_header "9. Hardcoded Player Names"
  local found=0
  while IFS= read -r -d '' f; do
    if grep -qP '@[aeprs]\[.*name=[^$\s(]' "$f"; then
      warn "[hardcoded-name] $f"
      grep -nP '@[aeprs]\[.*name=[^$\s(]' "$f" | while IFS= read -r m; do detail "$m"; done
      found=1
    fi
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No hardcoded player names."
}

check_function_path() {
  print_header "10. Function Path & Namespace Check"
  local found=0
  while IFS= read -r -d '' f; do
    mapfile -t bad < <(grep -nP '^\$?function\s+' "$f" 2>/dev/null)
    for lineinfo in "${bad[@]}"; do
      local lineno=${lineinfo%%:*}
      local line=${lineinfo#*:}
      if ! echo "$line" | grep -qP '^\$?function\s+(#|[a-z0-9_\-]+:[a-z0-9_/\-]+)'; then
        warn "[function-path] $f:$lineno"
        detail "$line"
        found=$((found + 1))
      fi
    done
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "All function calls have correct namespace."
}

check_function_length() {
  print_header "11. Function Length Check"
  local found=0
  while IFS= read -r -d '' f; do
    local lines=$(wc -l < "$f")
    if [ "$lines" -gt 150 ]; then
      warn "[long-function] $f ($lines lines)"
      detail "Consider splitting into sub-functions."
      found=$((found + 1))
    fi
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No excessively long functions."
}

check_load_tick() {
  print_header "12. load.json & tick.json Check"
  local load=0 tick=0
  [[ -f "data/minecraft/tags/function/load.json" || -f "data/minecraft/tags/functions/load.json" ]] && load=1
  [[ -f "data/minecraft/tags/function/tick.json" || -f "data/minecraft/tags/functions/tick.json" ]] && tick=1
  [ $load -eq 1 ] && pass "load.json exists." || warn "[missing-tag] load.json not found!"
  [ $tick -eq 1 ] && pass "tick.json exists." || warn "[missing-tag] tick.json not found!"
}

check_dangerous_commands() {
  print_header "13. Dangerous Commands Check"
  local found=0
  while IFS= read -r -d '' f; do
    mapfile -t bad < <(grep -nP '\bkill @e(?!\[)|\bfill\b.*\bair\b|\bparticle\b.*\s[0-9]{4,}\s' "$f" 2>/dev/null)
    for lineinfo in "${bad[@]}"; do
      warn "[dangerous-cmd] $f:${lineinfo%%:*}"
      detail "${lineinfo#*:}"
      found=$((found + 1))
    done
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No dangerous commands found."
}

check_unreachable_code() {
  print_header "14. Unreachable Code After Return"
  local found=0
  while IFS= read -r -d '' f; do
    python3 - "$f" <<'PYEOF' || rc=$?
import sys
path = sys.argv[1]
lines = open(path).readlines()
found = 0
for i, line in enumerate(lines):
    s = line.strip()
    if not s or s.startswith('#'): continue
    if s.startswith('return ') and not s.startswith('return run'):
        for j in range(i+1, len(lines)):
            nxt = lines[j].strip()
            if nxt and not nxt.startswith('#'):
                print(f" \033[33m⚠ WARN:\033[0m [unreachable] {path}:{j+1}")
                print(f" \033[33m→\033[0m {lines[j].rstrip()}")
                found += 1
                break
sys.exit(found)
PYEOF
    rc=${rc:-$?}
    found=$((found + rc))
  done < <(find_mcfunction)
  [ $found -eq 0 ] && pass "No unreachable code found."
}

check_overlay_dirs() {
  print_header "15. Overlay Directory Check"
  local missing=0
  for dir in "${MC_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
      warn "[missing-dir] '$dir' not found"
      missing=$((missing + 1))
    else
      pass "Directory exists: $dir"
    fi
  done
  [ $missing -eq 0 ] && pass "All overlay directories present."
}

print_summary() {
  echo ""
  echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
  echo -e "${BOLD} LINT SUMMARY${RESET}"
  echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
  echo -e " ${GREEN}✔ Passed :${RESET} ${TOTAL_PASSED}"
  echo -e " ${YELLOW}⚠ Warns :${RESET} ${TOTAL_WARNS}"
  echo -e " ${RED}✖ Errors :${RESET} ${TOTAL_ERRORS}"
  echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
  echo ""

  if [ $TOTAL_ERRORS -gt 0 ]; then
    echo -e "${RED}${BOLD}FAILED — ${TOTAL_ERRORS} error(s) must be fixed.${RESET}"
    exit 1
  elif [ $TOTAL_WARNS -gt 0 ]; then
    echo -e "${YELLOW}${BOLD}PASSED WITH WARNINGS.${RESET}"
    exit 0
  else
    echo -e "${GREEN}${BOLD}ALL CHECKS PASSED.${RESET}"
    exit 0
  fi
}

main() {
  echo -e "${BOLD}${CYAN} AME mcfunction Linter (Stabil v2)${RESET}"
  echo -e "${CYAN} $(date '+%Y-%m-%d %H:%M:%S')${RESET}"

  check_overlay_dirs
  check_crlf
  check_macro_prefix
  check_useless_dollar
  check_input_comment
  check_at_p
  check_trailing_whitespace
  check_json
  check_deprecated_text
  check_hardcoded_names
  check_function_path
  check_function_length
  check_load_tick
  check_dangerous_commands
  check_unreachable_code

  print_summary
}

main "$@"
