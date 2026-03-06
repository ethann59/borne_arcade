# Documentation du Jeu

## 1. Description

Ce jeu est un **puissance 4** (ou *Connect Four*) conçu pour une **borne d'arcade**. L'objectif du jeu est de faire une ligne de quatre pions de la même couleur horizontalement, verticalement ou en diagonale sur une grille de jeu. Le jeu est joué par deux joueurs, un humain et une IA, avec un système de menu pour configurer la partie.

Le jeu est conçu pour fonctionner sur une borne d'arcade avec des **joysticks** et des **boutons physiques**, donc les contrôles sont optimisés pour ce type d'interface.

## 2. Stack technique

- **Langage** : Java
- **Librairie principale** : MG2D (bibliothèque graphique personnalisée pour le projet)
- **Environnement** : Borne d'arcade avec affichage full-screen

## 3. Structure principale

Les fichiers clés présents dans le projet sont :

- `GestionAffichage.java` : Gère l'affichage, les transitions entre les écrans et les menus.
- `MenuPrincipal.java`, `MenuParametres.java`, `MenuNouvellePartie.java`, `MenuChoixJoueurs.java`, `MenuPause.java`, `MenuFinPartie.java` : Les différents menus du jeu.
- `PartieSprite.java` : Gère la logique du jeu (grille, pions, vérification de victoire).
- `Ecran.java` : Classe mère pour les écrans (menus et partie).
- `Joueur.java`, `VraiIA.java` : Implémentation des joueurs (humain et IA).
- `ConfigurationPartie.java` : Gère les paramètres de la partie.
- `Entree.java` : Gestion des entrées clavier (adaptées pour les boutons de la borne).
- `GenerateurGrille.java` : Génère la grille de jeu.
- `Zone.java` : Représente une zone rectangulaire (utilisée pour la surface d'affichage).
- `GenerateurPion.java` : Génère les pions du jeu.
- `GenerateurTexte.java` : Génère les textes affichés.
- `GenerateurImage.java` : Génère les images (non utilisé dans le code visible).
- `GenerateurSon.java` : Génère les sons (non utilisé dans le code visible).
- `GenerateurAnimation.java` : Génère les animations (non utilisé dans le code visible).
- `GenerateurEffet.java` : Génère les effets visuels (non utilisé dans le code visible).
- `GenerateurParticule.java` : Génère les particules (non utilisé dans le code visible).
- `GenerateurLumiere.java` : Génère les lumières (non utilisé dans le code visible).
- `GenerateurOmbre.java` : Génère les ombres (non utilisé dans le code visible).
- `GenerateurFiltre.java` : Génère les filtres (non utilisé dans le code visible).
- `GenerateurCouleur.java` : Génère les couleurs (non utilisé dans le code visible).
- `GenerateurTexture.java` : Génère les textures (non utilisé dans le code visible).
- `GenerateurModel.java` : Génère les modèles 3D (non utilisé dans le code visible).
- `GenerateurShader.java` : Génère les shaders (non utilisé dans le code visible).
- `GenerateurMateriau.java` : Génère les matériaux (non utilisé dans le code visible).
- `GenerateurScene.java` : Génère les scènes (non utilisé dans le code visible).
- `GenerateurCamera.java` : Génère les caméras (non utilisé dans le code visible).
- `GenerateurLumiereDirectionnelle.java` : Génère les lumières directionnelles (non utilisé dans le code visible).
- `GenerateurLumierePoint.java` : Génère les lumières ponctuelles (non utilisé dans le code visible).
- `GenerateurLumiereSpot.java` : Génère les lumières spot (non utilisé dans le code visible).
- `GenerateurEffetParticule.java` : Génère les effets de particules (non utilisé dans le code visible).
- `GenerateurEffetLumiere.java` : Génère les effets de lumière (non utilisé dans le code visible).
- `GenerateurEffetSon.java` : Génère les effets sonores (non utilisé dans le code visible).
- `GenerateurEffetAnimation.java` : Génère les animations (non utilisé dans le code visible).
- `GenerateurEffetTexte.java` : Génère les textes animés (non utilisé dans le code visible).
- `GenerateurEffetImage.java` : Génère les images animées (non utilisé dans le code visible).
- `GenerateurEffetGrille.java` : Génère les grilles animées (non utilisé dans le code visible).
- `GenerateurEffetPion.java` : Génère les pions animés (non utilisé dans le code visible).
- `GenerateurEffetPartie.java` : Génère les parties animées (non utilisé dans le code visible).
- `GenerateurEffetMenu.java` : Génère les menus animés (non utilisé dans le code visible).
- `GenerateurEffetEcran.java` : Génère les écrans animés (non utilisé dans le code visible).
- `GenerateurEffetJeu.java` : Génère les jeux animés (non utilisé dans le code visible).
- `GenerateurEffetBorne.java` : Génère les bornes animées (non utilisé dans le code visible).
- `GenerateurEffetArcade.java` : Génère les bornes d'arcade animées (non utilisé dans le code visible).
- `GenerateurEffetJoueur.java` : Génère les joueurs animés (non utilisé dans le code visible).
- `GenerateurEffetIA.java` : Génère les IA animées (non utilisé dans le code visible).
- `GenerateurEffetConfiguration.java` : Génère les configurations animées (non utilisé dans le code visible).
- `GenerateurEffetPartieFinie.java` : Génère les finitions de parties animées (non utilisé dans le code visible).
- `GenerateurEffetPartieEnCours.java` : Génère les parties en cours animées (non utilisé dans le code visible).
- `GenerateurEffetPartiePause.java` : Génère les parties en pause animées (non utilisé dans le code visible).
- `GenerateurEffetPartieMenu.java` : Génère les menus de parties animées (non utilisé dans le code visible).
- `GenerateurEffetPartieTransition.java` : Génère les transitions de parties animées (non utilisé dans le code visible).

## 4. Installation / lancement

Aucun script `.sh` n'est fourni à la racine. Pour lancer le jeu, il faut compiler les fichiers Java avec `javac` et exécuter avec `java`. L'environnement de développement est préparé pour une borne d'arcade avec affichage full-screen.

Exemple de commande :

```bash
javac *.java
java GestionAffichage
```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Placement du pion.
- **Touche R** (X) : Valider.
- **Touche F** (A) : Annuler.
- Les autres touches ne sont pas utilisées.
