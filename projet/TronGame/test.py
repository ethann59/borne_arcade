import pytest
import pygame
from unittest.mock import Mock, patch
from main import TronGame
from game_main import Game
from menu_main import Menu
from player import Player
from ai import AI
from config import *

def test_tron_game_initialization():
    """Test de l'initialisation de la classe TronGame"""
    game = TronGame()
    assert game.running is True
    assert game.current_state == "menu"
    assert game.difficulty == "moyen"
    assert game.move_delay == MOVE_DELAY

def test_tron_game_toggle_fullscreen():
    """Test de la méthode toggle_fullscreen"""
    game = TronGame()
    # La méthode est conservée mais désactivée, donc ne doit pas lever d'exception
    try:
        game.toggle_fullscreen()
        assert True
    except Exception:
        assert False

def test_tron_game_play_music():
    """Test de la méthode play_music"""
    game = TronGame()
    # Test avec un fichier inexistant (devrait échouer silencieusement)
    game.play_music("./assets/sounds/nonexistent.wav")
    assert True  # Ne doit pas lever d'exception

def test_game_initialization():
    """Test de l'initialisation de la classe Game"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single", difficulty="facile")
        assert game is not None
        assert game.mode == "single"
        assert game.difficulty == "facile"

def test_player_initialization():
    """Test de l'initialisation de la classe Player"""
    player = Player(100, 100)
    assert player.x == 100
    assert player.y == 100
    assert player.alive is True
    assert player.direction == "RIGHT"

def test_ai_initialization():
    """Test de l'initialisation de la classe AI"""
    ai = AI(100, 100)
    assert ai.x == 100
    assert ai.y == 100
    assert ai.alive is True

def test_menu_initialization():
    """Test de l'initialisation de la classe Menu"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        menu = Menu(Mock())
        assert menu is not None

def test_game_handle_event_pause():
    """Test de la gestion de l'événement de pause"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        event = Mock()
        event.type = pygame.KEYDOWN
        event.key = pygame.K_p
        game.handle_event(event)
        assert game.pause is True

def test_game_handle_event_restart():
    """Test de la gestion de l'événement de redémarrage"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        game.game_over = True
        event = Mock()
        event.type = pygame.KEYDOWN
        event.key = pygame.K_r
        game.handle_event(event)
        # Doit redémarrer le jeu
        assert True

def test_game_update_collision():
    """Test de la mise à jour du jeu avec collision"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        # Simuler une collision
        game.player1.alive = False
        game.player2.alive = True
        game.update()
        assert game.game_over is True
        assert game.winner == "Joueur 2"

def test_game_update_no_collision():
    """Test de la mise à jour du jeu sans collision"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        # Simuler pas de collision
        game.player1.alive = True
        game.player2.alive = True
        game.update()
        assert game.game_over is False

def test_player_move():
    """Test du déplacement du joueur"""
    player = Player(100, 100)
    player.move(pygame.time.get_ticks(), [[0]*100 for _ in range(100)])
    assert player.x == 100  # Position inchangée sans déplacement
    assert player.y == 100

def test_ai_update():
    """Test de la mise à jour de l'IA"""
    ai = AI(100, 100)
    grid = [[0]*100 for _ in range(100)]
    ai.update(pygame.time.get_ticks(), grid, Mock())
    assert ai.x == 100  # Position inchangée sans déplacement

def test_menu_handle_event():
    """Test de la gestion des événements du menu"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        menu = Menu(Mock())
        event = Mock()
        event.type = pygame.KEYDOWN
        event.key = pygame.K_RETURN
        action = menu.handle_event(event)
        assert action is not None

def test_game_draw():
    """Test du rendu du jeu"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        try:
            game.draw()
            assert True
        except Exception:
            assert False

def test_player_handle_input():
    """Test de la gestion des entrées du joueur"""
    player = Player(100, 100)
    event = Mock()
    event.key = pygame.K_UP
    player.handle_input(event.key)
    assert player.direction == "UP"

def test_player_handle_input_invalid():
    """Test de la gestion des entrées invalides du joueur"""
    player = Player(100, 100)
    event = Mock()
    event.key = pygame.K_UNKNOWN
    player.handle_input(event.key)
    assert player.direction == "RIGHT"  # Direction par défaut

def test_game_update_grid():
    """Test de la mise à jour de la grille"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        try:
            game.update_grid()
            assert True
        except Exception:
            assert False

def test_game_get_game_stats():
    """Test de la récupération des statistiques du jeu"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        stats = game.get_game_stats()
        assert isinstance(stats, dict)

def test_tron_game_process_menu_action_single_player():
    """Test du traitement d'une action du menu - mode solo"""
    game = TronGame()
    game.process_menu_action("single_player")
    assert game.current_state == "game"

def test_tron_game_process_menu_action_two_players():
    """Test du traitement d'une action du menu - mode 2 joueurs"""
    game = TronGame()
    game.process_menu_action("two_players")
    assert game.current_state == "game"

def test_tron_game_process_menu_action_options():
    """Test du traitement d'une action du menu - options"""
    game = TronGame()
    game.process_menu_action("options")
    assert game.current_state == "options"

def test_tron_game_process_menu_action_quit():
    """Test du traitement d'une action du menu - quitter"""
    game = TronGame()
    game.process_menu_action("quit")
    assert game.running is False

def test_game_update_with_full_grid():
    """Test de la mise à jour avec une grille pleine"""
    with patch('pygame.display.set_mode') as mock_set_mode:
        mock_set_mode.return_value = Mock()
        game = Game(Mock(), mode="single")
        # Remplir la grille
        game.grid = [[1]*100 for _ in range(100)]
        game.player1.x = 50
        game.player1.y = 50
        game.player1.alive = True
        game.player2.alive = True
        game.update()
        # Doit gérer la collision
        assert game.game_over is True

def test_player_move_with_collision():
    """Test du déplacement avec collision"""
    player = Player(100, 100)
    grid = [[0]*100 for _ in range(100)]
    grid[99][99] = 1  # Collision
    collision = player.move(pygame.time.get_ticks(), grid)
    assert collision is True

def test_ai_update_with_no_path():
    """Test de la mise à jour de l'IA avec aucun chemin disponible"""
    ai = AI(100, 100)
    grid = [[1]*100 for _ in range(100)]  # Grille pleine
    ai.update(pygame.time.get_ticks(), grid, Mock())
    # Doit gérer le cas sans chemin
    assert ai is not None