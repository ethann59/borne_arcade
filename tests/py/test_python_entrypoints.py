from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PROJET = ROOT / "projet"

PY_GAMES = {
    "ball-blast": ["src/__main__.py"],
    "TronGame": ["main.py"],
    "OsuTile": ["main.py"],
    "PianoTile": ["app/project.py"],
}


def test_python_entrypoints_exist():
    for game, candidates in PY_GAMES.items():
        game_dir = PROJET / game
        assert game_dir.is_dir(), f"Missing game dir: {game}"
        assert any((game_dir / c).is_file() for c in candidates), (
            f"Missing entrypoint for {game}: {candidates}"
        )


def test_requirements_are_not_empty():
    for req in PROJET.rglob("requirements.txt"):
        content = req.read_text(encoding="utf-8").strip()
        assert content, f"Empty requirements.txt: {req}"
