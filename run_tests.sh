#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

JUNIT_VERSION="1.10.2"
JUNIT_JAR="$ROOT_DIR/.tools/junit-platform-console-standalone-$JUNIT_VERSION.jar"

mkdir -p "$ROOT_DIR/.tools" "$ROOT_DIR/tests/bin"

if [ ! -f "$JUNIT_JAR" ]; then
  if command -v curl >/dev/null 2>&1; then
    curl -sSL -o "$JUNIT_JAR" "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$JUNIT_VERSION/junit-platform-console-standalone-$JUNIT_VERSION.jar"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$JUNIT_JAR" "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$JUNIT_VERSION/junit-platform-console-standalone-$JUNIT_VERSION.jar"
  else
    echo "curl or wget is required to download JUnit"
    exit 1
  fi
fi

javac -cp "$JUNIT_JAR" -d "$ROOT_DIR/tests/bin" $ROOT_DIR/tests/java/*.java
java -jar "$JUNIT_JAR" -cp "$ROOT_DIR/tests/bin" --scan-class-path

if command -v python3 >/dev/null 2>&1; then
  PIP_BREAK_SYSTEM_PACKAGES=1 python3 -m pip install --user -q pytest
  SDL_VIDEODRIVER=dummy python3 -m pytest -q "$ROOT_DIR/tests/py"
else
  echo "python3 not found, skipping python tests"
fi
