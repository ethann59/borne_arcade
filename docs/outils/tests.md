# Guide des tests

Ce guide explique comment exécuter et créer des tests pour les jeux de la borne d'arcade.

## 📋 Vue d'ensemble

La borne d'arcade contient trois types de tests :

1. **Tests générés par l'IA** : Créés automatiquement par le générateur
2. **Tests manuels existants** : Tests écrits par les développeurs
3. **Tests d'intégration** : Tests globaux de la borne

## 🧪 Tests générés par l'IA

### Localisation

Les tests IA sont créés dans chaque dossier de jeu :

```
projet/JavaSpace/TestsAI.java
projet/TronGame/test_ai.py
projet/CursedWare/test_ai.lua
```

### Génération

```bash
# Générer tests pour un jeu
./generate_docs.sh JavaSpace

# Générer tests pour tous les jeux
./generate_docs.sh
```

## ☕ Tests Java (JUnit 5)

### Prérequis

```bash
# Installer JUnit 5
sudo apt install junit5
```

Ou télécharger manuellement :
- `junit-platform-console-standalone-1.9.x.jar`

### Structure d'un test Java

```java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

class TestsAI {
    
    private Joueur joueur;
    
    @BeforeEach
    void setUp() {
        joueur = new Joueur(100, 100);
    }
    
    @Test
    @DisplayName("Test d'initialisation du joueur")
    void testJoueurInitialisation() {
        assertNotNull(joueur);
        assertEquals(100, joueur.getX());
        assertEquals(100, joueur.getY());
    }
    
    @Test
    void testDeplacementJoueur() {
        joueur.deplacer(10, 0);
        assertEquals(110, joueur.getX());
    }
    
    @Test
    void testCollision() {
        assertTrue(joueur.collision(100, 100));
        assertFalse(joueur.collision(200, 200));
    }
}
```

### Compiler les tests

```bash
cd projet/JavaSpace

# Compiler le jeu
javac -cp ../../MG2D *.java

# Compiler les tests
javac -cp .:junit-platform-console-standalone.jar TestsAI.java
```

### Exécuter les tests

```bash
java -jar junit-platform-console-standalone.jar \
    --class-path . \
    --scan-class-path
```

Sortie attendue :

```
JUnit Platform Console Launcher
├─ TestsAI ✔
│  ├─ testJoueurInitialisation() ✔
│  ├─ testDeplacementJoueur() ✔
│  └─ testCollision() ✔

Test run finished after 145 ms
[         3 tests successful      ]
[         0 tests failed          ]
```

## 🐍 Tests Python (pytest)

### Prérequis

```bash
pip3 install pytest pytest-cov
```

### Structure d'un test Python

```python
import pytest
from joueur import Joueur
from jeu import Jeu

@pytest.fixture
def joueur():
    """Fixture pour créer un joueur de test"""
    return Joueur(100, 100)

def test_joueur_initialisation(joueur):
    assert joueur is not None
    assert joueur.x == 100
    assert joueur.y == 100

def test_deplacement(joueur):
    joueur.deplacer(10, 0)
    assert joueur.x == 110

def test_collision(joueur):
    assert joueur.collision(100, 100) is True
    assert joueur.collision(200, 200) is False

@pytest.mark.parametrize("x,y,expected", [
    (100, 100, True),
    (200, 200, False),
    (-10, -10, False),
])
def test_collision_parametree(joueur, x, y, expected):
    assert joueur.collision(x, y) == expected
```

### Exécuter les tests

```bash
cd projet/TronGame

# Lancer tous les tests
pytest test_ai.py

# Mode verbeux
pytest test_ai.py -v

# Avec couverture de code
pytest test_ai.py --cov=.

# Générer rapport HTML de couverture
pytest test_ai.py --cov=. --cov-report=html
```

Sortie :

```
======================== test session starts ========================
collected 5 items

test_ai.py .....                                              [100%]

========================= 5 passed in 0.12s =========================
```

## 🌙 Tests Lua (busted)

### Prérequis

```bash
sudo apt install lua5.1 luarocks
sudo luarocks install busted
```

### Structure d'un test Lua

```lua
-- test_ai.lua

describe("Joueur", function()
    local Joueur = require("joueur")
    
    local joueur
    
    before_each(function()
        joueur = Joueur.new(100, 100)
    end)
    
    it("s'initialise correctement", function()
        assert.is_not_nil(joueur)
        assert.equals(100, joueur.x)
        assert.equals(100, joueur.y)
    end)
    
    it("se déplace correctement", function()
        joueur:deplacer(10, 0)
        assert.equals(110, joueur.x)
    end)
    
    it("détecte les collisions", function()
        assert.is_true(joueur:collision(100, 100))
        assert.is_false(joueur:collision(200, 200))
    end)
end)

describe("Jeu", function()
    local Jeu = require("main")
    
    it("démarre correctement", function()
        local jeu = Jeu.new()
        assert.is_not_nil(jeu)
    end)
end)
```

### Exécuter les tests

```bash
cd projet/CursedWare

# Lancer les tests
busted test_ai.lua

# Mode verbeux
busted test_ai.lua -v

# Avec couverture
busted test_ai.lua --coverage
```

## 🔍 Tests d'intégration

### Test du clavier de la borne

```bash
./TestClavierBorneArcade.sh
```

ou

```bash
javac ClavierBorneArcade.java TestClavierBorneArcade.java
java TestClavierBorneArcade
```

### Test des high scores

```bash
javac HighScore.java LigneHighScore.java TestHighScore.java
java TestHighScore
```

## 📊 Couverture de code

### Java avec JaCoCo

```bash
# Télécharger JaCoCo
wget https://repo1.maven.org/maven2/org/jacoco/jacoco/0.8.10/jacoco-0.8.10.zip
unzip jacoco-0.8.10.zip

# Exécuter avec couverture
java -javaagent:jacocoagent.jar \
    -jar junit-platform-console-standalone.jar \
    --class-path . \
    --scan-class-path

# Générer rapport
java -jar jacococli.jar report jacoco.exec \
    --classfiles . \
    --sourcefiles . \
    --html report/
```

### Python avec pytest-cov

```bash
pytest test_ai.py --cov=. --cov-report=html
firefox htmlcov/index.html
```

### Lua avec luacov

```bash
sudo luarocks install luacov
busted test_ai.lua --coverage
luacov
cat luacov.report.out
```

## ✅ Bonnes pratiques

### Nommage des tests

```python
# ✅ Bon - descriptif
def test_joueur_perd_vie_avec_collision():
    ...

# ❌ Mauvais - vague
def test_1():
    ...
```

### Organisation

```
projet/JavaSpace/
├── src/               # Code source
│   ├── Joueur.java
│   └── Jeu.java
├── test/              # Tests organisés
│   ├── TestJoueur.java
│   └── TestJeu.java
└── TestsAI.java       # Tests IA
```

### Assertions claires

```python
# ✅ Bon
assert joueur.vie == 3, "Le joueur devrait avoir 3 vies au départ"

# ❌ Moins clair
assert joueur.vie == 3
```

### Fixtures et setup

Utilisez les fixtures/setup pour éviter la duplication :

```python
@pytest.fixture
def jeu_initialise():
    jeu = Jeu()
    jeu.charger_niveau(1)
    return jeu

def test_avec_jeu(jeu_initialise):
    assert jeu_initialise.niveau == 1
```

## 🐛 Dépannage

### Tests Java ne compilent pas

```bash
# Vérifier classpath
javac -cp .:../../MG2D:junit.jar TestsAI.java

# Vérifier imports
# Il faut : import org.junit.jupiter.api.*;
```

### Tests Python non trouvés

```bash
# pytest cherche test_*.py ou *_test.py
mv tests.py test_ai.py

# Vérifier PYTHONPATH
export PYTHONPATH=$PYTHONPATH:$(pwd)
```

### Busted ne trouve pas les modules

```lua
-- Ajouter le chemin de recherche
package.path = package.path .. ";./src/?.lua"
local Joueur = require("joueur")
```

## 📈 CI/CD (Intégration Continue)

### Script de test global

```bash
#!/bin/bash
# test_all.sh

echo "Tests Java..."
for game in JavaSpace Columns DinoRail; do
    cd "projet/$game"
    ./run_tests.sh || exit 1
    cd ../..
done

echo "Tests Python..."
for game in TronGame Pong; do
    cd "projet/$game"
    pytest test_ai.py || exit 1
    cd ../..
done

echo "✅ Tous les tests sont passés!"
```

## 📚 Ressources

### Frameworks de test

- **JUnit 5** : https://junit.org/junit5/
- **pytest** : https://pytest.org/
- **busted** : https://olivinelabs.com/busted/

### Guides

- [Générateur de tests](generator.md)
- [Installation](../installation/generator.md)
- [Maintenance](../maintenance/procedures.md)

---

**Bon testing! 🧪**
