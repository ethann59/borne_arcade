# Dépannage

Solutions aux problèmes courants de la borne d'arcade.

## 🔴 Problèmes de démarrage

### La borne ne démarre pas

#### Symptômes
- Double-clic sur `lancerBorne.sh` ne fait rien
- Erreur "Permission denied"

#### Solutions

1. **Vérifier les permissions**
   ```bash
   ls -la lancerBorne.sh
   chmod +x lancerBorne.sh
   ./lancerBorne.sh
   ```

2. **Lancer depuis le terminal**
   ```bash
   cd ~/borne_arcade
   bash lancerBorne.sh
   ```

3. **Vérifier Java**
   ```bash
   which java
   java -version
   ```
   
   Si Java n'est pas installé :
   ```bash
   sudo apt install openjdk-25-jdk
   ```

### Erreur "ClassNotFoundException"

#### Symptômes
```
Error: Could not find or load main class Main
```

#### Solutions

1. **Recompiler**
   ```bash
   ./compilation.sh
   ```

2. **Vérifier le CLASSPATH**
   ```bash
   ls -la Main.class
   javac -cp ".:MG2D/*" Main.java
   ```

3. **Vérifier MG2D**
   ```bash
   ls -la MG2D/
   # Doit contenir des .jar ou .class
   ```

## 🎮 Problèmes de jeux

### Un jeu ne se lance pas

#### Symptômes
- Le jeu crashe au démarrage
- Fenêtre noire puis fermeture
- Message d'erreur

#### Solutions

1. **Lancer en mode debug**
   ```bash
   # Java
   cd projet/JavaSpace
   java -verbose Main 2> error.log
   cat error.log
   
   # Python
   cd projet/TronGame
   python3 main.py 2>&1 | tee error.log
   
   # Lua
   cd projet/CursedWare
   love . 2>&1 | tee error.log
   ```

2. **Vérifier les dépendances**
   
   **Java :**
   ```bash
   javac -cp ../../MG2D *.java
   ```
   
   **Python :**
   ```bash
   pip3 install pygame
   python3 -c "import pygame; print(pygame.version.ver)"
   ```
   
   **Lua :**
   ```bash
   love --version
   ```

3. **Restaurer depuis backup**
   ```bash
   cp -r backups/JavaSpace_20260301/* projet/JavaSpace/
   ```

### Jeu lent / Lag

#### Symptômes
- FPS bas
- Saccades
- Délais de réponse

#### Solutions

1. **Vérifier les ressources système**
   ```bash
   top
   # Chercher des processus gourmands
   ```

2. **Fermer les applications inutiles**
   ```bash
   # Lister les processus
   ps aux | grep -E 'java|python|love'
   
   # Tuer un processus
   kill -9 PID
   ```

3. **Réduire la qualité graphique**
   
   Éditer les paramètres du jeu (si disponible)

4. **Vérifier la température**
   ```bash
   # Si disponible
   sensors
   ```

### Pas de son

#### Symptômes
- Jeu silencieux
- Erreur "Audio device not found"

#### Solutions

1. **Vérifier PulseAudio**
   ```bash
   pulseaudio --check
   pulseaudio --start
   ```

2. **Tester le son système**
   ```bash
   speaker-test -t wav -c 2
   ```

3. **Vérifier les fichiers audio**
   ```bash
   ls -la projet/JavaSpace/sons/
   file projet/JavaSpace/sons/*.wav
   ```

4. **Permissions audio**
   ```bash
   groups $USER | grep audio
   # Si absent:
   sudo usermod -a -G audio $USER
   # Puis se déconnecter/reconnecter
   ```

## ⌨️ Problèmes de clavier

### Les boutons ne répondent pas

#### Symptômes
- Touches non détectées
- Mauvais mapping (gauche = droite, etc.)

#### Solutions

1. **Tester le clavier**
   ```bash
   ./TestClavierBorneArcade.sh
   ```
   
   Appuyer sur chaque touche et vérifier le code :
   - Flèches : `VK_UP`, `VK_DOWN`, etc.
   - J1 : `VK_R`, `VK_T`, `VK_Y`, `VK_F`, `VK_G`, `VK_H`, etc.
   - J2 : `VK_O`, `VK_L`, `VK_K`, `VK_M`, etc.

2. **Vérifier le layout clavier**
   ```bash
   localectl status
   ```
   
   Changer si nécessaire :
   ```bash
   sudo localectl set-x11-keymap fr
   ```

3. **Reconfigurer ClavierBorneArcade.java**
   ```bash
   nano ClavierBorneArcade.java
   # Vérifier les mappings
   ./compilation.sh
   ```

### Touches collées

#### Symptômes
- Une action continue sans appuyer
- Personnage se déplace tout seul

#### Solutions

1. **Vérifier physiquement le clavier**
2. **Nettoyer les contacts**
3. **Redémarrer**
   ```bash
   sudo systemctl restart gdm  # Ou équivalent
   ```

## 🛠️ Problèmes de génération de documentation

### "Serveur Ollama inaccessible"

#### Symptômes
```
[ERREUR] Le serveur Ollama n'est pas accessible.
```

#### Solutions

1. **Vérifier la connexion réseau**
   ```bash
   ping 10.22.28.190
   curl http://10.22.28.190:11434/api/version
   ```

2. **Vérifier le firewall**
   ```bash
   sudo ufw status
   # Si bloqué:
   sudo ufw allow from 10.22.28.0/24
   ```

3. **Utiliser Ollama localement**
   ```bash
   # Installer
   curl -fsSL https://ollama.com/install.sh | sh
   
   # Démarrer
   ollama serve &
   
   # Télécharger un modèle
   ollama pull gemma2:2b
   
   # Modifier l'URL dans ollama_wrapper_iut.py
   nano ollama_wrapper_iut.py
   # Changer: base_url: str = "http://localhost:11434"
   ```

### "Modèle non trouvé"

#### Symptômes
```
Error: model 'gemma2:latest' not found
```

#### Solutions

1. **Lister les modèles disponibles**
   ```bash
   python3 -c "from ollama_wrapper_iut import OllamaWrapper; print([m.name for m in OllamaWrapper().list_models()])"
   ```

2. **Utiliser un modèle disponible**
   ```bash
   python3 generate_docs_and_tests.py --model gemma2:2b
   ```

3. **Télécharger le modèle** (si serveur local)
   ```bash
   ollama pull gemma2:latest
   ollama list
   ```

### Timeout lors de la génération

#### Symptômes
```
TimeoutError: Request timed out after 120s
```

#### Solutions

1. **Utiliser un modèle plus léger**
   ```bash
   python3 generate_docs_and_tests.py --model gemma2:2b
   ```

2. **Augmenter le timeout**
   ```bash
   nano ollama_wrapper_iut.py
   # Ligne 130: timeout_s: float = 300.0  # 5 minutes
   ```

3. **Limiter les fichiers analysés**
   ```bash
   nano generate_docs_and_tests.py
   # Ligne 185: max_files: int = 10  # Au lieu de 20
   ```

### Documentation incomplète ou mauvaise qualité

#### Symptômes
- Texte tronqué
- Informations manquantes
- Réponses hors sujet

#### Solutions

1. **Relancer pour le jeu spécifique**
   ```bash
   ./generate_docs.sh JavaSpace
   ```

2. **Essayer un autre modèle**
   ```bash
   python3 generate_docs_and_tests.py --game JavaSpace --model mistral:latest
   ```

3. **Augmenter num_predict**
   ```bash
   nano generate_docs_and_tests.py
   # Dans generate_documentation():
   # options={"temperature": 0.7, "num_predict": 3000}
   ```

4. **Améliorer le prompt**
   
   Éditer les prompts dans `generate_docs_and_tests.py` lignes 225-250

## 📊 Problèmes de compilation

### Erreurs de compilation Java

#### Symptômes
```
error: package MG2D does not exist
```

#### Solutions

1. **Vérifier MG2D**
   ```bash
   ls -la MG2D/
   ```

2. **Fixer le classpath**
   ```bash
   cd projet/JavaSpace
   javac -cp "../../MG2D/*" *.java
   ```

3. **Recompiler complètement**
   ```bash
   ./clean.sh
   ./compilation.sh
   ```

### Module Python non trouvé

#### Symptômes
```
ModuleNotFoundError: No module named 'pygame'
```

#### Solutions

1. **Installer le module**
   ```bash
   pip3 install pygame
   ```

2. **Vérifier Python**
   ```bash
   python3 --version
   which python3
   ```

3. **Vérifier PYTHONPATH**
   ```bash
   echo $PYTHONPATH
   export PYTHONPATH=$PYTHONPATH:$(pwd)
   ```

### Erreur Love2D

#### Symptômes
```
Error: Cannot load game at path '/projet/CursedWare'
```

#### Solutions

1. **Vérifier main.lua**
   ```bash
   cd projet/CursedWare
   ls -la main.lua
   ```

2. **Lancer Love2D correctement**
   ```bash
   love .
   # Pas: love main.lua
   ```

3. **Vérifier la syntaxe Lua**
   ```bash
   luac -p main.lua
   ```

## 💾 Problèmes de sauvegarde

### Scores non sauvegardés

#### Symptômes
- High scores réinitialisés à chaque lancement
- Fichier `highscore` vide

#### Solutions

1. **Vérifier les permissions**
   ```bash
   ls -la projet/JavaSpace/highscore
   chmod 666 projet/JavaSpace/highscore
   ```

2. **Vérifier l'espace disque**
   ```bash
   df -h
   ```

3. **Recréer le fichier**
   ```bash
   touch projet/JavaSpace/highscore
   chmod 666 projet/JavaSpace/highscore
   ```

4. **Debug dans le code**
   
   Vérifier que le jeu appelle bien `HighScore.sauvegarder()`

### Fichiers corrompus

#### Symptômes
```
java.io.IOException: Invalid format
```

#### Solutions

1. **Restaurer depuis backup**
   ```bash
   cp backups/scores_20260301/highscore projet/JavaSpace/
   ```

2. **Réinitialiser**
   ```bash
   echo "" > projet/JavaSpace/highscore
   ```

## 🌐 Problèmes réseau

### Cannot resolve hostname

#### Solutions
```bash
# Vérifier DNS
cat /etc/resolv.conf

# Tester
nslookup google.com

# Ping
ping 10.22.28.190
```

### Proxy

Si derrière un proxy :

```bash
export http_proxy="http://proxy.iut.fr:3128"
export https_proxy="http://proxy.iut.fr:3128"
```

## 📝 Logs et diagnostic

### Activer les logs

```bash
# Java
java -Djava.util.logging.config.file=logging.properties Main

# Python
python3 main.py --debug

# Ou dans le code Python:
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Analyser les logs

```bash
# Filtrer les erreurs
grep -i error logs/*.log

# Dernières lignes
tail -50 logs/borne.log

# Suivre en temps réel
tail -f logs/borne.log
```

## 🆘 Dernier recours

### Réinstallation complète

```bash
# Sauvegarder
cp -r borne_arcade borne_arcade_backup

# Nettoyer
cd borne_arcade
./clean.sh
rm -rf __pycache__ *.pyc

# Recompiler
./compilation.sh

# Tester
./test_ollama.py
./JavaSpace.sh
```

### Restauration depuis Git

```bash
# Si vous utilisez Git
git status
git reset --hard HEAD
git clean -fd

# Ou réinstaller
git clone <url> borne_arcade_new
```

## 📞 Obtenir de l'aide

### Informations à fournir

При demande d'aide, fournir :

1. **Description du problème**
2. **Étapes pour reproduire**
3. **Messages d'erreur complets**
4. **Logs** (voir section ci-dessus)
5. **Environnement**:
   ```bash
   cat > diagnostic.txt << EOF
   OS: $(uname -a)
   Java: $(java -version 2>&1)
   Python: $(python3 --version)
   Love2D: $(love --version 2>&1)
   Espace disque: $(df -h | grep -E 'Avail|/$')
   EOF
   ```

### Checklist de dépannage

- [ ] Problème reproduit au moins 2 fois
- [ ] Logs collectés
- [ ] Recherche dans ce guide effectuée
- [ ] Solutions simples essayées (redémarrage, recompilation)
- [ ] Backup effectué avant modifications

## 📚 Ressources

- [Procédures de maintenance](procedures.md)
- [Guide des tests](../outils/tests.md)
- [Installation](../installation/overview.md)

---

**Si le problème persiste, contactez l'équipe de maintenance avec les informations de diagnostic.**
