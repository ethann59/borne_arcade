#!/usr/bin/env python3
"""
Programme de génération automatique de documentation et de tests
pour les jeux de la borne d'arcade en utilisant l'IA Ollama.

Ce script parcourt tous les projets de jeux (sauf Galad-Scott),
analyse leur code source et génère :
- Documentation technique complète
- Tests unitaires appropriés au langage utilisé
"""

import json
import os
import re
import shutil
import subprocess
import sys
import urllib.request
from pathlib import Path
from typing import Dict, List, Optional, Tuple

from ollama_wrapper_iut import OllamaWrapper, OllamaGenerateResult


class GameAnalyzer:
    """Analyse les jeux et génère la documentation et les tests."""
    
    # Dossier racine du projet
    PROJECT_ROOT = Path(__file__).parent
    GAMES_DIR = PROJECT_ROOT / "projet"
    MKDOCS_GAMES_DIR = PROJECT_ROOT / "docs" / "jeux"
    
    # Jeux à exclure
    EXCLUDED_GAMES = {"Galad-Scott"}
    
    # Extensions de fichiers source par langage
    LANGUAGE_EXTENSIONS = {
        "java": [".java"],
        "python": [".py"],
        "lua": [".lua"],
        "c": [".c", ".cpp", ".h", ".hpp"],
        "javascript": [".js", ".ts"],
    }
    
    def __init__(self, model: str = "gemma3:latest", verbose: bool = True, run_tests: bool = False):
        """
        Initialise l'analyseur.
        
        Args:
            model: Nom du modèle Ollama à utiliser
            verbose: Afficher les messages de progression
        """
        self.ollama = OllamaWrapper()
        self.model = model
        self.verbose = verbose
        self.run_tests = run_tests

    def ensure_model_available(self) -> bool:
        """
        Vérifie que le modèle demandé est installé sur Ollama.

        Returns:
            True si le modèle est disponible, False sinon.
        """
        try:
            models = self.ollama.list_models()
        except Exception as e:
            print(f"[ERREUR] Impossible de récupérer la liste des modèles Ollama : {e}")
            return False

        available_models = {m.name for m in models}
        if self.model in available_models:
            return True

        print(f"[ERREUR] Modèle introuvable : {self.model}")
        if available_models:
            print("Modèles disponibles :")
            for name in sorted(available_models):
                print(f"  - {name}")
        else:
            print("Aucun modèle installé sur Ollama.")
        print(f"Installe le modèle avec : ollama pull {self.model}")
        return False
        
    def log(self, message: str) -> None:
        """Affiche un message si verbose est activé."""
        if self.verbose:
            print(f"[INFO] {message}")
    
    def detect_language(self, game_path: Path) -> Optional[str]:
        """
        Détecte le langage principal d'un jeu.
        
        Args:
            game_path: Chemin vers le dossier du jeu
            
        Returns:
            Nom du langage détecté ou None
        """
        # Compte les fichiers par extension
        extension_counts: Dict[str, int] = {}
        
        for root, _, files in os.walk(game_path):
            for file in files:
                ext = Path(file).suffix.lower()
                extension_counts[ext] = extension_counts.get(ext, 0) + 1
        
        # Détermine le langage dominant
        for lang, extensions in self.LANGUAGE_EXTENSIONS.items():
            total = sum(extension_counts.get(ext, 0) for ext in extensions)
            if total > 0:
                return lang
        
        return None
    
    def collect_source_files(self, game_path: Path, language: str, max_files: int = 20) -> List[Path]:
        """
        Collecte les fichiers sources d'un jeu.
        
        Args:
            game_path: Chemin vers le dossier du jeu
            language: Langage du jeu
            max_files: Nombre maximum de fichiers à collecter
            
        Returns:
            Liste des chemins vers les fichiers sources
        """
        extensions = self.LANGUAGE_EXTENSIONS.get(language, [])
        source_files: List[Path] = []
        
        for root, _, files in os.walk(game_path):
            # Ignore certains dossiers
            root_path = Path(root)
            if any(skip in root_path.parts for skip in ["__pycache__", "node_modules", ".git", "assets", "img", "sounds", "fonts"]):
                continue
            
            for file in files:
                if Path(file).suffix.lower() in extensions:
                    source_files.append(Path(root) / file)
                    if len(source_files) >= max_files:
                        return source_files
        
        return source_files
    
    def read_source_file(self, file_path: Path, max_lines: int = 500) -> str:
        """
        Lit un fichier source avec gestion d'erreurs.
        
        Args:
            file_path: Chemin vers le fichier
            max_lines: Nombre maximum de lignes à lire
            
        Returns:
            Contenu du fichier (tronqué si nécessaire)
        """
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                lines = f.readlines()[:max_lines]
                content = "".join(lines)
                if len(lines) == max_lines:
                    content += f"\n... (fichier tronqué, {max_lines} lignes max)"
                return content
        except Exception as e:
            return f"Erreur de lecture : {e}"

    def read_game_metadata(self, game_path: Path) -> Dict[str, str]:
        """
        Lit les métadonnées du jeu (description et touches borne).

        Args:
            game_path: Dossier du jeu

        Returns:
            Dictionnaire contenant description/touches
        """
        def read_optional_file(filename: str, max_chars: int = 3000) -> str:
            file_path = game_path / filename
            if not file_path.exists():
                return ""
            try:
                content = file_path.read_text(encoding="utf-8", errors="replace").strip()
                return content[:max_chars]
            except Exception:
                return ""

        return {
            "description": read_optional_file("description.txt"),
            "controls": read_optional_file("bouton.txt"),
        }
    
    def generate_documentation(
        self,
        game_name: str,
        language: str,
        source_files: List[Path],
        metadata: Dict[str, str],
    ) -> str:
        """
        Génère la documentation d'un jeu en utilisant l'IA.
        
        Args:
            game_name: Nom du jeu
            language: Langage du jeu
            source_files: Liste des fichiers sources
            
        Returns:
            Documentation générée en Markdown
        """
        self.log(f"Génération de la documentation pour {game_name}...")
        
        # Prépare le contexte du code
        code_context = f"# Jeu: {game_name}\n# Langage: {language}\n\n"

        if metadata.get("description"):
            code_context += "## Description du jeu (description.txt)\n"
            code_context += metadata["description"] + "\n\n"
        if metadata.get("controls"):
            code_context += "## Touches et contrôles borne (bouton.txt)\n"
            code_context += metadata["controls"] + "\n\n"
        
        for file_path in source_files[:10]:  # Limite à 10 fichiers pour ne pas saturer
            relative_path = file_path.relative_to(self.GAMES_DIR)
            content = self.read_source_file(file_path, max_lines=200)
            code_context += f"\n## Fichier: {relative_path}\n```{language}\n{content}\n```\n\n"
        
        # Construit le prompt
        prompt = f"""Tu es un expert en documentation technique de jeux pour BORNE D'ARCADE.
    Analyse le code et les métadonnées suivantes puis génère une documentation concise et factuelle en français.

{code_context}

    Contraintes importantes :
    - Ce jeu est utilisé sur une borne d'arcade (joysticks + boutons), adapte le vocabulaire à ce contexte.
    - Réutilise explicitement les informations de description.txt et bouton.txt quand elles existent.
    - N'invente pas de fichiers, de frameworks, ni de mécaniques non visibles dans le contexte.
    - N'encapsule PAS toute la réponse dans un bloc ```markdown.

    Génère une MINI documentation au format Markdown avec exactement ces sections :

    1. **Description** (objectif + contexte borne)
    2. **Stack technique** (langage, lib principale)
    3. **Structure principale** (fichiers/modules clés réellement présents)
    4. **Installation / lancement** (priorité au script `.sh` à la racine s'il existe)
    5. **Contrôles borne** (à partir de bouton.txt, sinon "à vérifier")

Réponds UNIQUEMENT avec le contenu Markdown, sans préambule."""

        try:
            result: OllamaGenerateResult = self.ollama.generate_text(
                model=self.model,
                prompt=prompt,
                options={"temperature": 0.7, "num_predict": 2000}
            )
            return self._sanitize_documentation_markdown(result.response)
        except Exception as e:
            self.log(f"Erreur lors de la génération de documentation : {e}")
            return f"# Documentation {game_name}\n\nErreur de génération : {e}"
    
    def generate_tests(self, game_name: str, language: str, source_files: List[Path]) -> str:
        """
        Génère des tests unitaires pour un jeu en utilisant l'IA.
        
        Args:
            game_name: Nom du jeu
            language: Langage du jeu
            source_files: Liste des fichiers sources
            
        Returns:
            Code de tests généré
        """
        self.log(f"Génération des tests pour {game_name}...")
        
        # Frameworks de test par langage
        test_frameworks = {
            "java": "JUnit 5",
            "python": "pytest",
            "lua": "busted",
            "javascript": "Jest",
            "c": "Check",
        }
        
        framework = test_frameworks.get(language, "framework standard")
        
        # Prépare le contexte du code (fichiers principaux uniquement)
        code_context = f"# Jeu: {game_name}\n# Langage: {language}\n\n"
        
        for file_path in source_files[:5]:  # Limite à 5 fichiers pour les tests
            relative_path = file_path.relative_to(self.GAMES_DIR)
            content = self.read_source_file(file_path, max_lines=150)
            code_context += f"\n## Fichier: {relative_path}\n```{language}\n{content}\n```\n\n"
        
        # Construit le prompt
        prompt = f"""Tu es un expert en tests logiciels. Analyse le code suivant et génère des tests unitaires complets en {language} avec {framework}.

{code_context}

Génère des tests unitaires qui couvrent :

1. **Tests de base** : Initialisation, constructeurs
2. **Tests fonctionnels** : Logique métier, mécaniques de jeu
3. **Tests de cas limites** : Gestion d'erreurs, valeurs extrêmes
4. **Tests d'intégration** : Interactions entre composants

Pour {language}, utilise {framework} et respecte les conventions du langage.

Réponds UNIQUEMENT avec le code de test complet, sans commentaires préliminaires. Inclus les imports nécessaires."""

        try:
            result: OllamaGenerateResult = self.ollama.generate_text(
                model=self.model,
                prompt=prompt,
                options={"temperature": 0.5, "num_predict": 2000}
            )
            return result.response
        except Exception as e:
            self.log(f"Erreur lors de la génération de tests : {e}")
            return f"// Erreur de génération de tests : {e}"
    
    def save_documentation(self, game_path: Path, documentation: str) -> None:
        """
        Sauvegarde la documentation générée.
        
        Args:
            game_path: Chemin vers le dossier du jeu
            documentation: Contenu de la documentation
        """
        doc_path = game_path / "DOCUMENTATION.md"
        try:
            with open(doc_path, "w", encoding="utf-8") as f:
                f.write(documentation)
            self.log(f"Documentation sauvegardée : {doc_path}")
        except Exception as e:
            self.log(f"Erreur lors de la sauvegarde de la documentation : {e}")
    
    def save_tests(self, game_path: Path, language: str, tests: str) -> None:
        """
        Sauvegarde les tests générés.
        
        Args:
            game_path: Chemin vers le dossier du jeu
            language: Langage du jeu
            tests: Code des tests
        """
        # Détermine le nom et l'extension du fichier de test
        test_filenames = {
            "java": "tests/Tests.java",
            "python": "test.py",
            "lua": "test.lua",
            "javascript": "test.js",
            "c": "test.c",
        }
        
        test_filename = test_filenames.get(language, "test.txt")
        test_path = game_path / test_filename
        test_path.parent.mkdir(parents=True, exist_ok=True)
        cleaned_tests = self._strip_code_fences(tests)

        # Nettoie l'ancien emplacement pour éviter de casser la compilation des jeux Java.
        if language == "java":
            legacy_test_path = game_path / "Tests.java"
            if legacy_test_path.exists():
                try:
                    legacy_test_path.unlink()
                    self.log(f"Ancien test Java supprimé : {legacy_test_path}")
                except Exception as e:
                    self.log(f"Impossible de supprimer {legacy_test_path} : {e}")
        
        try:
            with open(test_path, "w", encoding="utf-8") as f:
                f.write(cleaned_tests)
            self.log(f"Tests sauvegardés : {test_path}")
        except Exception as e:
            self.log(f"Erreur lors de la sauvegarde des tests : {e}")

    def _strip_code_fences(self, content: str) -> str:
        """
        Supprime les fences Markdown éventuels autour du code généré.

        Gère des formats comme :
        - ```python\n...\n```
        - ```java\n...\n```
        - <garbage>```python\n...\n```  (artefact IA avec déchets avant le fence)
        """
        text = content.strip()

        # Cas 0: du texte parasite avant le premier bloc fenced (ex: unicode IA).
        # On cherche le premier ``` et on ne garde que le bloc fenced.
        first_fence = text.find("```")
        if first_fence > 0:
            text = text[first_fence:].strip()

        # Cas 1: tout le contenu est dans un unique bloc fenced.
        if text.startswith("```") and text.endswith("```"):
            lines = text.splitlines()
            if len(lines) >= 2:
                return "\n".join(lines[1:-1]).strip() + "\n"

        # Cas 2: on extrait le premier bloc fenced trouvé.
        match = re.search(r"```[a-zA-Z0-9_+-]*\n(.*?)\n```", text, flags=re.DOTALL)
        if match:
            return match.group(1).strip() + "\n"

        return content

    def _ensure_junit_jar(self, junit_jar: Path) -> None:
        """Télécharge le JAR JUnit 5 standalone si absent."""
        JUNIT_URL = (
            "https://repo1.maven.org/maven2/org/junit/platform/"
            "junit-platform-console-standalone/1.11.4/"
            "junit-platform-console-standalone-1.11.4.jar"
        )
        junit_jar.parent.mkdir(parents=True, exist_ok=True)
        if self.verbose:
            print(f"[INFO] JUnit 5 non trouvé, téléchargement depuis Maven Central...")
        try:
            urllib.request.urlretrieve(JUNIT_URL, str(junit_jar))
            if self.verbose:
                print(f"[INFO] JUnit 5 téléchargé dans {junit_jar.relative_to(self.PROJECT_ROOT)}")
        except Exception as e:
            print(f"[WARN] Échec du téléchargement de JUnit 5 : {e}")

    def _sanitize_documentation_markdown(self, content: str) -> str:
        """
        Nettoie les artefacts fréquents de sortie IA dans les docs markdown.

        - Supprime un éventuel wrapper global ```markdown ... ```
        - Supprime certaines lignes parasites en tête de document
        """
        text = content.strip()

        # Supprime un wrapper markdown global (sans toucher aux blocs internes)
        if text.startswith("```markdown") and text.endswith("```"):
            lines = text.splitlines()
            if len(lines) >= 2:
                text = "\n".join(lines[1:-1]).strip()

        lines = text.splitlines()
        cleaned: List[str] = []
        for idx, line in enumerate(lines):
            normalized = line.strip().lower()
            if idx == 0 and (
                "hollowed out" in normalized
                or "initialized job response" in normalized
                or normalized == "```markdown"
            ):
                continue
            cleaned.append(line)

        return "\n".join(cleaned).rstrip() + "\n"

    def run_generated_tests(self, game_path: Path, language: str) -> Tuple[bool, str]:
        """
        Exécute (ou valide) les tests générés selon le langage.

        Returns:
            (succès, message)
        """
        try:
            if language == "python":
                test_file = game_path / "test.py"
                if not test_file.exists():
                    return False, "test.py introuvable"

                if shutil.which("pytest"):
                    result = subprocess.run(
                        ["pytest", "-q", str(test_file.name)],
                        cwd=game_path,
                        capture_output=True,
                        text=True,
                    )
                    if result.returncode == 0:
                        return True, "pytest OK"
                    stderr_excerpt = (result.stdout + "\n" + result.stderr).strip()[:220]
                    return False, f"pytest en échec: {stderr_excerpt}"

                # Fallback minimal si pytest absent
                result = subprocess.run(
                    ["python3", "-m", "py_compile", str(test_file.name)],
                    cwd=game_path,
                    capture_output=True,
                    text=True,
                )
                if result.returncode == 0:
                    return True, "py_compile OK (pytest absent)"
                return False, f"py_compile en échec: {result.stderr.strip()[:220]}"

            if language == "lua":
                test_file = game_path / "test.lua"
                if not test_file.exists():
                    return False, "test.lua introuvable"

                if shutil.which("busted"):
                    result = subprocess.run(
                        ["busted", str(test_file.name)],
                        cwd=game_path,
                        capture_output=True,
                        text=True,
                    )
                    if result.returncode == 0:
                        return True, "busted OK"
                    stderr_excerpt = (result.stdout + "\n" + result.stderr).strip()[:220]
                    return False, f"busted en échec: {stderr_excerpt}"

                if shutil.which("luac"):
                    result = subprocess.run(
                        ["luac", "-p", str(test_file.name)],
                        cwd=game_path,
                        capture_output=True,
                        text=True,
                    )
                    if result.returncode == 0:
                        return True, "luac -p OK (busted absent)"
                    return False, f"luac en échec: {result.stderr.strip()[:220]}"

                return False, "ni busted ni luac disponibles"

            if language == "java":
                test_file = game_path / "tests" / "Tests.java"
                if not test_file.exists():
                    return False, "tests/Tests.java introuvable"

                if not shutil.which("javac"):
                    return False, "javac introuvable"

                # Classpath : JUnit 5 + MG2D ; Sourcepath : code du jeu + racine
                junit_jar = self.PROJECT_ROOT / "lib" / "junit-platform-console-standalone.jar"
                mg2d_jar = self.PROJECT_ROOT / "MG2D" / "mg2d.jar"

                # Télécharger JUnit si absent
                if not junit_jar.exists():
                    self._ensure_junit_jar(junit_jar)

                cp_parts = []
                if junit_jar.exists():
                    cp_parts.append(str(junit_jar))
                if mg2d_jar.exists():
                    cp_parts.append(str(mg2d_jar))

                sourcepath_parts = [
                    str(game_path),
                    str(game_path / "src"),
                    str(self.PROJECT_ROOT),
                ]

                cmd = ["javac"]
                if cp_parts:
                    cmd += ["-cp", ":".join(cp_parts)]
                cmd += ["-sourcepath", ":".join(sourcepath_parts)]
                cmd.append(str(test_file))

                result = subprocess.run(
                    cmd,
                    cwd=game_path,
                    capture_output=True,
                    text=True,
                )

                # Nettoie les .class générés
                for class_file in game_path.rglob("*.class"):
                    class_file.unlink(missing_ok=True)

                if result.returncode == 0:
                    return True, "Compilation Java des tests OK"
                # Filtre les warnings container du stderr
                err = "\n".join(
                    l for l in result.stderr.splitlines()
                    if "os,container" not in l
                ).strip()[:220]
                return False, f"Compilation Java en échec: {err}"

            return False, f"Langage non supporté pour exécution des tests: {language}"
        except Exception as e:
            return False, f"Erreur exécution tests: {e}"

    def copy_docs_to_mkdocs(self, game_names: List[str]) -> None:
        """
        Copie les documentations générées vers docs/jeux pour MkDocs.

        Args:
            game_names: Liste des jeux à copier
        """
        if not self.MKDOCS_GAMES_DIR.exists():
            self.log(f"Dossier MkDocs introuvable : {self.MKDOCS_GAMES_DIR}")
            return

        copied_count = 0
        for game_name in game_names:
            src_doc = self.GAMES_DIR / game_name / "DOCUMENTATION.md"
            if not src_doc.exists():
                self.log(f"Documentation absente pour {game_name} : {src_doc}")
                continue

            dest_doc = self.MKDOCS_GAMES_DIR / f"{game_name}.md"
            try:
                shutil.copy2(src_doc, dest_doc)
                copied_count += 1
                self.log(f"Doc copiée vers MkDocs : {dest_doc}")
            except Exception as e:
                self.log(f"Erreur de copie vers MkDocs pour {game_name} : {e}")

        self.log(f"Copie vers MkDocs terminée : {copied_count}/{len(game_names)} fichiers")
    
    def process_game(self, game_name: str) -> Tuple[bool, str]:
        """
        Traite un jeu : détection, analyse, génération doc et tests.
        
        Args:
            game_name: Nom du jeu
            
        Returns:
            (succès, message)
        """
        game_path = self.GAMES_DIR / game_name
        
        if not game_path.is_dir():
            return False, "N'est pas un dossier"
        
        if game_name in self.EXCLUDED_GAMES:
            return False, "Exclu de l'analyse"
        
        self.log(f"\n{'='*60}")
        self.log(f"Traitement du jeu : {game_name}")
        self.log(f"{'='*60}")
        
        # Détecte le langage
        language = self.detect_language(game_path)
        if not language:
            return False, "Langage non détecté"
        
        self.log(f"Langage détecté : {language}")
        
        # Collecte les fichiers sources
        source_files = self.collect_source_files(game_path, language)
        if not source_files:
            return False, "Aucun fichier source trouvé"
        
        self.log(f"{len(source_files)} fichiers sources trouvés")
        
        metadata = self.read_game_metadata(game_path)

        # Génère la documentation
        documentation = self.generate_documentation(game_name, language, source_files, metadata)
        self.save_documentation(game_path, documentation)
        
        # Génère les tests
        tests = self.generate_tests(game_name, language, source_files)
        self.save_tests(game_path, language, tests)

        test_status = "tests non exécutés"
        if self.run_tests:
            tests_ok, tests_msg = self.run_generated_tests(game_path, language)
            test_status = f"tests: {'OK' if tests_ok else 'ECHEC'} ({tests_msg})"
        
        return True, f"Documentation et tests générés ({language}) - {test_status}"
    
    def process_all_games(self) -> None:
        """Traite tous les jeux du dossier projet."""
        if not self.GAMES_DIR.exists():
            print(f"[ERREUR] Le dossier {self.GAMES_DIR} n'existe pas.")
            return
        
        # Vérifie que le serveur Ollama est accessible
        if not self.ollama.is_server_running():
            print("[ERREUR] Le serveur Ollama n'est pas accessible.")
            print("Veuillez démarrer Ollama avec : ollama serve")
            return

        # Vérifie que le modèle demandé est disponible
        if not self.ensure_model_available():
            return
        
        self.log(f"Serveur Ollama OK - Modèle utilisé : {self.model}")
        
        # Liste tous les jeux
        games = [d.name for d in self.GAMES_DIR.iterdir() if d.is_dir()]
        games.sort()
        
        self.log(f"\n{len(games)} jeux trouvés dans {self.GAMES_DIR}")
        
        # Traite chaque jeu
        results = {}
        for game_name in games:
            success, message = self.process_game(game_name)
            results[game_name] = (success, message)
        
        # Affiche le résumé
        print("\n" + "="*60)
        print("RÉSUMÉ DU TRAITEMENT")
        print("="*60)
        
        success_count = sum(1 for s, _ in results.values() if s)
        
        for game_name, (success, message) in results.items():
            status = "✓ OK" if success else "✗ SKIP"
            print(f"{status:8} | {game_name:25} | {message}")
        
        print(f"\nTotal : {success_count}/{len(games)} jeux traités avec succès")

        # Copie les documentations générées vers MkDocs
        successful_games = [name for name, (success, _) in results.items() if success]
        self.copy_docs_to_mkdocs(successful_games)


def main():
    """Point d'entrée principal."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Génère automatiquement la documentation et les tests des jeux"
    )
    parser.add_argument(
        "--model",
        default="gemma3:latest",
        help="Modèle Ollama à utiliser (défaut: gemma3:latest)"
    )
    parser.add_argument(
        "--game",
        help="Traiter uniquement un jeu spécifique"
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Mode silencieux (moins de messages)"
    )
    parser.add_argument(
        "--run-tests",
        action="store_true",
        help="Exécuter/valider les tests générés juste après leur création"
    )
    
    args = parser.parse_args()
    
    # Crée l'analyseur
    analyzer = GameAnalyzer(model=args.model, verbose=not args.quiet, run_tests=args.run_tests)

    # Vérifie les prérequis Ollama (serveur + modèle)
    if not analyzer.ollama.is_server_running():
        print("[ERREUR] Le serveur Ollama n'est pas accessible.")
        print("Veuillez démarrer Ollama avec : ollama serve")
        sys.exit(1)
    if not analyzer.ensure_model_available():
        sys.exit(1)
    
    # Traite soit un jeu spécifique, soit tous les jeux
    if args.game:
        success, message = analyzer.process_game(args.game)
        status = "Succès" if success else "Échec"
        print(f"{status}: {message}")
        if success:
            analyzer.copy_docs_to_mkdocs([args.game])
    else:
        analyzer.process_all_games()


if __name__ == "__main__":
    main()
