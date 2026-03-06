#!/usr/bin/env bash
set -u -o pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

echo "=========================================="
echo "Lancement des tests existants (sans génération)"
echo "=========================================="
echo ""

total=0
passed=0
failed=0
skipped=0

report_ok() {
  local msg="$1"
  total=$((total + 1))
  passed=$((passed + 1))
  echo "[OK]   $msg"
}

report_fail() {
  local msg="$1"
  total=$((total + 1))
  failed=$((failed + 1))
  echo "[FAIL] $msg"
}

report_skip() {
  local msg="$1"
  total=$((total + 1))
  skipped=$((skipped + 1))
  echo "[SKIP] $msg"
}

run_python_tests() {
  local found=0
  while IFS= read -r test_file; do
    found=1
    local test_dir
    test_dir="$(dirname "$test_file")"
    local game
    game="$(basename "$test_dir")"

    if command -v pytest >/dev/null 2>&1; then
      if (cd "$test_dir" && pytest -q "$(basename "$test_file")"); then
        report_ok "Python: $game"
      else
        report_fail "Python: $game"
      fi
    else
      if (cd "$test_dir" && python3 -m py_compile "$(basename "$test_file")"); then
        report_ok "Python (py_compile fallback): $game"
      else
        report_fail "Python (py_compile fallback): $game"
      fi
    fi
  done < <(find projet -type f -name "test.py" | sort)

  if [ "$found" -eq 0 ]; then
    report_skip "Aucun test Python trouvé"
  fi
}

run_lua_tests() {
  local found=0
  while IFS= read -r test_file; do
    found=1
    local test_dir
    test_dir="$(dirname "$test_file")"
    local game
    game="$(basename "$test_dir")"

    if command -v busted >/dev/null 2>&1; then
      if (cd "$test_dir" && busted "$(basename "$test_file")"); then
        report_ok "Lua: $game"
      else
        report_fail "Lua: $game"
      fi
    elif command -v luac >/dev/null 2>&1; then
      if (cd "$test_dir" && luac -p "$(basename "$test_file")"); then
        report_ok "Lua (luac -p fallback): $game"
      else
        report_fail "Lua (luac -p fallback): $game"
      fi
    else
      report_skip "Lua: $game (ni busted ni luac disponibles)"
    fi
  done < <(find projet -type f -name "test.lua" | sort)

  if [ "$found" -eq 0 ]; then
    report_skip "Aucun test Lua trouvé"
  fi
}

ensure_junit_jar() {
  local JUNIT_JAR="$ROOT_DIR/lib/junit-platform-console-standalone.jar"
  if [ -f "$JUNIT_JAR" ]; then
    return 0
  fi
  echo "[INFO] JUnit 5 non trouvé, téléchargement..."
  mkdir -p "$ROOT_DIR/lib"
  local JUNIT_URL="https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.11.4/junit-platform-console-standalone-1.11.4.jar"
  if command -v wget >/dev/null 2>&1; then
    wget -q -O "$JUNIT_JAR" "$JUNIT_URL"
  elif command -v curl >/dev/null 2>&1; then
    curl -sL -o "$JUNIT_JAR" "$JUNIT_URL"
  else
    echo "[WARN] Impossible de télécharger JUnit (ni wget ni curl disponibles)"
    return 1
  fi
  if [ -f "$JUNIT_JAR" ]; then
    echo "[INFO] JUnit 5 téléchargé dans lib/"
    return 0
  else
    echo "[WARN] Échec du téléchargement de JUnit 5"
    return 1
  fi
}

run_java_tests() {
  local found=0
  local JUNIT_JAR="$ROOT_DIR/lib/junit-platform-console-standalone.jar"
  local MG2D_JAR="$ROOT_DIR/MG2D/mg2d.jar"

  # Télécharger JUnit si nécessaire
  ensure_junit_jar

  while IFS= read -r test_file; do
    found=1
    local game_dir
    game_dir="$(dirname "$(dirname "$test_file")")"
    local game
    game="$(basename "$game_dir")"

    if ! command -v javac >/dev/null 2>&1; then
      report_skip "Java: $game (javac indisponible)"
      continue
    fi

    if [ ! -f "$JUNIT_JAR" ]; then
      report_skip "Java: $game (JUnit 5 JAR manquant — téléchargement échoué)"
      continue
    fi

    # Classpath : JUnit 5 + MG2D ; Sourcepath : code du jeu + racine du projet
    local CP="$JUNIT_JAR"
    [ -f "$MG2D_JAR" ] && CP="$CP:$MG2D_JAR"

    if javac -cp "$CP" -sourcepath "$game_dir:$game_dir/src:$ROOT_DIR" "$test_file" 2>&1 | grep -v "os,container" | grep -q "error:"; then
      report_fail "Java (compilation): $game"
    else
      report_ok "Java (compilation): $game"
    fi

    find "$game_dir" -name "*.class" -delete 2>/dev/null
  done < <(find projet -type f -path "*/tests/*.java" | sort)

  if [ "$found" -eq 0 ]; then
    report_skip "Aucun test Java trouvé"
  fi
}

run_python_tests
run_lua_tests
run_java_tests

echo ""
echo "=========================================="
echo "Résumé"
echo "=========================================="
echo "Total : $total"
echo "OK    : $passed"
echo "FAIL  : $failed"
echo "SKIP  : $skipped"

if [ "$failed" -gt 0 ]; then
  exit 1
fi

exit 0