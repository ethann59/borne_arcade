# Procédures de maintenance

Guide de maintenance régulière de la borne d'arcade.

## 📅 Maintenance quotidienne

### Vérification de la borne

#### 1. Test de démarrage

```bash
cd ~/borne_arcade

# Lancer le menu principal
./lancerBorne.sh
```

Vérifier :
- ✅ Le menu s'affiche correctement
- ✅ Tous les jeux sont listés
- ✅ Les boutons répondent

#### 2. Test des périphériques

```bash
# Tester le clavier
./TestClavierBorneArcade.sh
```

Vérifier :
- ✅ Joysticks (haut/bas/gauche/droite)
- ✅ Boutons J1 (R,T,Y,F,G,H)
- ✅ Boutons J2 (A,Z,E,Q,S,D)

#### 3. Test audio

Lancer un jeu avec son :

```bash
./JavaSpace.sh
```

Vérifier :
- ✅ Musique de fond
- ✅ Effets sonores
- ✅ Volume approprié

## 🔄 Maintenance hebdomadaire

### Sauvegarde des scores

```bash
# Créer un dossier de sauvegarde
mkdir -p backups/scores_$(date +%Y%m%d)

# Copier tous les fichiers highscore
find projet -name "highscore" -exec cp {} backups/scores_$(date +%Y%m%d)/ \;

# Vérifier
ls -la backups/scores_$(date +%Y%m%d)/
```

### Nettoyage des fichiers temporaires

```bash
# Supprimer les fichiers .class orphelins
./clean.sh

# Ou manuellement
find . -name "*.class" -delete
find . -name "__pycache__" -type d -exec rm -rf {} +
find . -name "*.pyc" -delete
```

### Mise à jour de la documentation

```bash
# Régénérer la documentation pour les jeux modifiés
./generate_docs.sh NomDuJeu

# Ou pour tous
./generate_docs.sh
```

### Vérification des logs

```bash
# Si vous avez activé les logs
tail -f logs/borne.log

# Rechercher les erreurs
grep -i error logs/*.log
grep -i exception logs/*.log
```

## 🗓️ Maintenance mensuelle

### Mise à jour du système

```bash
sudo apt update
sudo apt upgrade

# Vérifier Java
java -version

# Vérifier Python
python3 --version

# Vérifier Love2D
love --version
```

### Test complet de tous les jeux

```bash
#!/bin/bash
# test_all_games.sh

games=(
    "ball-blast"
    "Columns"
    "CursedWare"
    "DinoRail"
    "InitialDrift"
    "JavaSpace"
    "Kowasu_Renga"
    "Minesweeper"
    "OsuTile"
    "PianoTile"
    "Pong"
    "Puissance_X"
    "Snake_Eater"
    "TronGame"
)

for game in "${games[@]}"; do
    echo "Testing $game..."
    timeout 10 ./"$game".sh > /dev/null 2>&1
    if [ $? -eq 124 ]; then
        echo "  ✅ $game démarre"
    else
        echo "  ❌ $game ERREUR"
    fi
done
```

### Recompilation complète

```bash
# Nettoyer
./clean.sh

# Recompiler
./compilation.sh

# Vérifier les erreurs
echo $?  # Doit être 0
```

### Vérification de l'espace disque

```bash
# Espace utilisé par la borne
du -sh .

# Détail par dossier
du -h --max-depth=1 | sort -h

# Nettoyer si nécessaire
rm -rf backups/old_*
```

## 🔧 Maintenance des jeux

### Ajout d'un nouveau jeu

1. **Créer la structure**

```bash
cd projet
mkdir NouveauJeu
cd NouveauJeu
```

2. **Créer les fichiers requis**

```bash
# Description
echo "Description courte du jeu" > description.txt

# Configuration boutons
cat > bouton.txt << EOF
# Boutons utilisés
fleche_haut
fleche_bas
r
t
EOF

# Fichier highscore
touch highscore
```

3. **Créer le script de lancement**

```bash
cat > ../NouveauJeu.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")/projet/NouveauJeu"
java Main
# ou python3 main.py
# ou love .
EOF

chmod +x ../NouveauJeu.sh
```

4. **Générer la documentation**

```bash
cd ../..
./generate_docs.sh NouveauJeu
```

### Mise à jour d'un jeu existant

1. **Sauvegarder les scores**

```bash
cp projet/JavaSpace/highscore projet/JavaSpace/highscore.bak
```

2. **Modifier le code**

```bash
cd projet/JavaSpace
# Éditer les fichiers...
```

3. **Recompiler**

```bash
javac -cp ../../MG2D *.java
```

4. **Tester**

```bash
cd ../..
./JavaSpace.sh
```

5. **Régénérer la documentation**

```bash
./generate_docs.sh JavaSpace
```

### Suppression d'un jeu

1. **Sauvegarder les données**

```bash
cp -r projet/AncienJeu backups/AncienJeu_$(date +%Y%m%d)
```

2. **Supprimer le jeu**

```bash
rm -rf projet/AncienJeu
rm AncienJeu.sh
```

3. **Mettre à jour le menu principal**

```bash
nano Main.java  # Retirer le jeu de la liste
./compilation.sh
```

## 📊 Monitoring

### Statistiques d'utilisation

```bash
# Jeux les plus joués (basé sur les scores)
for game in projet/*/highscore; do
    lines=$(wc -l < "$game")
    echo "$(dirname "$game" | xargs basename): $lines parties"
done | sort -t: -k2 -rn
```

### Santé du système

```bash
# CPU
top -bn1 | head -20

# Mémoire
free -h

# Température (si disponible)
sensors
```

### État des services

Si vous avez des services :

```bash
# Ollama
curl -s http://10.22.28.190:11434/api/version

# Serveur web (si applicable)
systemctl status apache2
```

## 🔐 Sécurité

### Permissions des fichiers

```bash
# Scripts exécutables
chmod +x *.sh
chmod +x projet/*/*.sh

# Fichiers de données en lecture seule
chmod 444 projet/*/description.txt
chmod 444 projet/*/bouton.txt

# Fichiers de score en lecture/écriture
chmod 666 projet/*/highscore
```

### Mise à jour de sécurité

```bash
# Vérifier les vulnérabilités Python
pip3 list --outdated

# Mettre à jour les packages
pip3 install --upgrade pygame

# Audit Java (si outils disponibles)
# https://www.cve.org
```

## 📝 Documentation des changements

### Journal de maintenance

Créer `CHANGELOG.md` :

```markdown
# Journal de maintenance

## 2026-03-03

### Ajouté
- Nouveau jeu : SuperPong
- Documentation automatique via IA

### Modifié
- JavaSpace : correction bug collision
- TronGame : amélioration contrôles

### Supprimé
- Ancien jeu de test

## 2026-02-15
...
```

### Git

Si vous utilisez Git :

```bash
# Commiter les changements
git add .
git commit -m "Maintenance: mise à jour JavaSpace et docs"

# Pousser
git push origin main

# Tag de version
git tag -a v1.2.0 -m "Version maintenance mars 2026"
git push --tags
```

## 🚨 Procédures d'urgence

### La borne ne démarre plus

```bash
# 1. Vérifier les permissions
ls -la lancerBorne.sh
chmod +x lancerBorne.sh

# 2. Vérifier Java
which java
java -version

# 3. Recompiler
./clean.sh
./compilation.sh

# 4. Lancer manuellement
java Main
```

### Un jeu crashe au démarrage

```bash
# 1. Vérifier les dépendances
cd projet/JavaSpace
javac -cp ../../MG2D *.java

# 2. Tester avec logs
java -verbose Main 2> error.log

# 3. Restaurer depuis backup
cp -r ../../backups/JavaSpace_YYYYMMDD/* .
```

### Perte de scores

```bash
# Restaurer depuis backup
cp backups/scores_YYYYMMDD/highscore projet/JavaSpace/

# Ou réinitialiser
echo "" > projet/JavaSpace/highscore
```

## 📞 Contact et support

### Logs à collecter en cas de problème

```bash
# Créer un rapport
cat > rapport_bug.txt << EOF
Date : $(date)
Système : $(uname -a)
Java : $(java -version 2>&1)
Python : $(python3 --version)

Erreur :
$(cat error.log)
EOF
```

### Checklist avant de contacter le support

- [ ] Erreur reproduite au moins 2 fois
- [ ] Logs collectés
- [ ] Dernières modifications documentées
- [ ] Tentatives de résolution essayées

## 📚 Ressources

- [Dépannage détaillé](troubleshooting.md)
- [Guide des tests](../outils/tests.md)
- [Retour à l'accueil](../index.md)
