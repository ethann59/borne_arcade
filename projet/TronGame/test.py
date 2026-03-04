import pytest
from tron_game import TronGame, Menu, Game
from tron_game.config import FULLSCREEN, SCREEN_WIDTH, SCREEN_HEIGHT, TITLE

def test_tron_game_initialization():
    game = TronGame()
    assert game.screen
    assert game.menu
    assert game.clock
    assert game.current_state == "menu"
    assert game.difficulty == "moyen"
    assert game.move_delay == MOVE_DELAY
    assert game.fullscreen_mode == FULLSCREEN

def test_menu_handle_event():
    game = TronGame()
    game.menu.handle_event(pygame.KEYDOWN)
    assert game.current_state == "menu"

def test_game_update():
    game = Game(TronGame().screen, mode="single", difficulty="moyen", move_delay=MOVE_DELAY)
    game.update()
    assert game.game is not None

def test_game_handle_event():
    game = Game(TronGame().screen, mode="single", difficulty="moyen", move_delay=MOVE_DELAY)
    game.handle_event(pygame.KEYDOWN)
    assert game.game is not None

def test_game_update_game_over():
    game = Game(TronGame().screen, mode="single", difficulty="moyen", move_delay=MOVE_DELAY)
    game.update()
    assert game.game.alive is False

def test_score_screen_handle_event():
    game = Game(TronGame().screen, mode="single", difficulty="moyen", move_delay=MOVE_DELAY)
    score_screen = ScoreScreen(game.screen, game.get_game_stats())
    score_screen.handle_event(pygame.KEYDOWN)
    assert score_screen.handle_event is not None
