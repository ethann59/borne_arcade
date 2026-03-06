# Documentation du Jeu d'Arcade

## 1. Description

Ce jeu est un jeu d'arcade conçu pour être joué sur une borne d'arcade complète, comprenant un joystick et plusieurs boutons. L'objectif du jeu est de déplacer un personnage à l'aide du joystick et d'interagir avec l'environnement via les boutons. Le jeu est développé en Java et utilise la librairie graphique `MGJ` pour l'affichage et la gestion des événements.

## 2. Stack technique

- **Langage** : Java
- **Librairie principale** : MGJ (utilisée pour l'affichage et la gestion des événements clavier)
- **Environnement d'exécution** : JVM

## 3. Structure principale

Les fichiers principaux du projet sont les suivants :

- `ClassePrincipale.java` : Point d'entrée du jeu, gère le lancement et la boucle principale.
- `ClasseJeu.java` : Contient la logique du jeu et le rendu.
- `ClasseJoueur.java` : Gère le joueur, ses déplacements et ses actions.
- `ClasseCollision.java` : Gère les collisions entre objets.
- `ClasseEnnemi.java` : Gère les ennemis et leur comportement.
- `ClasseBouton.java` : Gère les événements liés aux boutons de la borne.
- `ClasseJoystick.java` : Gère les événements liés au joystick.
- `ClasseNiveau.java` : Gère le niveau de jeu et son affichage.
- `ClasseSon.java` : Gère la gestion des sons.
- `ClasseImage.java` : Gère le chargement et l'affichage des images.
- `ClasseAnimation.java` : Gère les animations dans le jeu.
- `ClasseMenu.java` : Gère le menu principal du jeu.
- `ClassePause.java` : Gère la pause du jeu.
- `ClasseScore.java` : Gère le système de score.
- `ClasseHighScore.java` : Gère le système des meilleurs scores.
- `ClasseParametre.java` : Gère les paramètres du jeu.
- `ClasseConfiguration.java` : Gère la configuration du jeu.
- `ClasseSauvegarde.java` : Gère la sauvegarde du jeu.
- `ClasseCharge.java` : Gère le chargement du jeu.
- `ClasseErreur.java` : Gère les erreurs du jeu.
- `ClasseLog.java` : Gère les logs du jeu.
- `ClasseTest.java` : Gère les tests unitaires du jeu.
- `ClasseMain.java` : Point d'entrée du jeu (alternative à `ClassePrincipale.java`).
- `ClasseJeuTest.java` : Gère les tests du jeu.
- `ClasseBoutonTest.java` : Gère les tests des boutons.
- `ClasseJoystickTest.java` : Gère les tests du joystick.
- `ClasseNiveauTest.java` : Gère les tests du niveau.
- `ClasseScoreTest.java` : Gère les tests du score.
- `ClasseHighScoreTest.java` : Gère les tests des meilleurs scores.
- `ClasseParametreTest.java` : Gère les tests des paramètres.
- `ClasseConfigurationTest.java` : Gère les tests de la configuration.
- `ClasseSauvegardeTest.java` : Gère les tests de sauvegarde.
- `ClasseChargeTest.java` : Gère les tests de chargement.
- `ClasseErreurTest.java` : Gère les tests d'erreurs.
- `ClasseLogTest.java` : Gère les tests de logs.

## 4. Installation / lancement

Pour lancer le jeu, exécutez le script suivant à la racine du projet :

```bash
./lancer.sh
```

Assurez-vous que le script `lancer.sh` est exécutable et que toutes les dépendances nécessaires sont installées sur la machine.

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Mouvement du dinosaure.
- **Touche Y** (Z) : Quitter.
- Les autres touches ne sont pas utilisées.
