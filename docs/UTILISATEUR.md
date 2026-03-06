# Guide utilisateur - Borne d'arcade pédagogique

## 🎮 Présentation générale

La borne d'arcade pédagogique est un système interactif permettant de jouer à plusieurs jeux en mode 2 joueurs. Elle est conçue pour l'IUT du Littoral Côte d'Opale et utilise un Raspberry Pi avec un écran 4:3 de résolution 1280x1024.

## 🕹️ Navigation dans le menu

### Accès au menu principal

Lors du démarrage de la borne, l'interface s'affiche automatiquement. Si vous êtes redirigé vers un terminal, patientez environ 10 à 15 secondes.

### Sélection du jeu

Utilisez le **joystick du joueur 1** :
- **Haut/Bas** : naviguer entre les jeux
- **Bouton F** : lancer le jeu sélectionné

### Quitter l'application

Pour quitter l'application :
- Appuyez sur le **bouton Z** du joueur 1
- Une confirmation s'affiche : validez avec le **bouton F**

## 🎮 Contrôles des jeux

### Mappage des touches

#### Joystick J1
- **Haut/Bas/Gauche/Droite** : flèches directionnelles

#### Joystick J2
- **Haut** : touche `O`
- **Bas** : touche `L`
- **Gauche** : touche `K`
- **Droite** : touche `M`

#### Boutons J1 (6 touches)
- **Ligne haute** : `R`, `T`, `Y`
- **Ligne basse** : `F`, `G`, `H`

#### Boutons J2 (6 touches)
- **Ligne haute** : `A`, `Z`, `E`
- **Ligne basse** : `Q`, `S`, `D`

> ⚠️ **Attention** : L'encodeur clavier est mal relié. Les touches réelles ne correspondent pas aux touches affichées. Voir le fichier `borne` pour les correspondances exactes.

## 🎯 Lancement des jeux

### Méthode 1 : Interface graphique

1. Sélectionnez un jeu avec les flèches du joystick J1
2. Appuyez sur le bouton F pour lancer le jeu

### Méthode 2 : Scripts shell

Chaque jeu possède un script shell exécutable :
```bash
./NomDuJeu.sh
```

Exemples :
```bash
./Pong.sh
./JavaSpace.sh
./Snake_Eater.sh
```

### Méthode 3 : Script de lancement global

```bash
./lancerBorne.sh
```

## 📊 Gestion des scores

Les scores sont gérés par les jeux eux-mêmes. Certains jeux peuvent afficher des scores à l'écran, d'autres peuvent les sauvegarder dans des fichiers texte.

## 🛠️ Résolution de problèmes fréquents

### Problème : L'interface ne démarre pas

1. Vérifiez que le Raspberry Pi est allumé
2. Patientez 10 à 15 secondes
3. Si rien ne se passe, redémarrez le système

### Problème : Impossible de sélectionner un jeu

1. Vérifiez que les contrôleurs sont bien branchés
2. Testez les flèches du joystick J1
3. Redémarrez le système si nécessaire

### Problème : Jeu ne démarre pas

1. Vérifiez que le script du jeu est exécutable :
   ```bash
   chmod +x NomDuJeu.sh
   ```
2. Vérifiez les dépendances du jeu
3. Essayez de lancer le jeu via le script shell

### Problème : Contrôles non fonctionnels

1. Vérifiez les câbles de connexion
2. Testez les touches individuellement
3. Consultez le fichier `borne` pour les correspondances réelles

### Problème : Écran noir ou déformé

1. Vérifiez la résolution de l'écran (1280x1024)
2. Vérifiez les câbles HDMI
3. Redémarrez le système

## 📂 Liste des jeux disponibles

Les jeux suivants sont disponibles sur la borne :

- **ball-blast** (Python/Pygame) — Détruire des balles avec un canon
- **Columns** (Java/MG2D) — Aligner des gemmes de même couleur
- **CursedWare** (Lua/LÖVE) — Collection de mini-jeux
- **DinoRail** (Java/MG2D) — Jeu d'évitement sur rails
- **InitialDrift** (Java/MG2D) — Jeu d'évitement de véhicules
- **JavaSpace** (Java/MG2D) — Shooter spatial vertical
- **Kowasu_Renga** (Java/MG2D) — Casse-briques
- **Minesweeper** (Java/MG2D) — Démineur
- **OsuTile** (Python/Pygame) — Jeu de réaction et timing
- **PianoTile** (Python/Pygame) — Jeu de piano interactif
- **Pong** (Java/MG2D) — Ping-pong classique à 2 joueurs
- **Puissance_X** (Java/MG2D) — Puissance 4 avec IA
- **Snake_Eater** (Java/MG2D) — Snake classique
- **TronGame** (Python/Pygame) — Tron à 2 joueurs

Le jeu "Galad-Scott" est un projet externe à la borne. Elle se télécharge et s'installe au premier lancement de la borne.

## 📚 Ressources complémentaires

- [Guide d'installation](installation/overview.md)
