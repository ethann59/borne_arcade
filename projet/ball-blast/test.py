import pytest
import pygame
import random
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))
from unittest.mock import patch, MagicMock
from ball import Ball
from bullet import Bullet
from player import Player
from game import Game
from constantes import SCREEN_WIDTH, SCREEN_HEIGHT, RED, WHITE, PLAYER_SPEED, BALL_SPEED_X, BALL_SPEED_FALL, BALL_TOP_BOUNCE, BALL_BOTTOM_BOUNCE

@pytest.fixture
def mock_pygame():
    with patch('pygame.init'):
        with patch('pygame.display.set_mode') as mock_set_mode:
            with patch('pygame.time.Clock') as mock_clock:
                with patch('pygame.mixer.init'):
                    with patch('pygame.mixer.music'):
                        yield mock_set_mode, mock_clock

@pytest.fixture
def mock_font():
    with patch('ball.font') as mock_font:
        yield mock_font

@pytest.fixture
def mock_random():
    with patch('random.randint') as mock_randint:
        yield mock_randint

def test_ball_initialization():
    ball = Ball(100, 50, 20, 0, RED)
    assert ball.rect.x == 100
    assert ball.rect.y == 50
    assert ball.radius == 20
    assert ball.color == RED
    assert ball.base_life_points >= 1
    assert ball.base_life_points <= 15
    assert ball.mask is not None

def test_ball_update_position():
    ball = Ball(100, 50, 20)
    initial_x = ball.rect.x
    initial_y = ball.rect.y
    ball.update()
    assert ball.rect.x != initial_x or ball.rect.y != initial_y

def test_ball_collision_bounce():
    ball = Ball(100, 50, 20)
    ball.rect.x = 0
    ball.speed_x = -5
    ball.update()
    assert ball.speed_x > 0

def test_ball_take_damage():
    ball = Ball(100, 50, 20)
    initial_life = ball.life_points
    is_destroyed = ball.take_damage()
    assert ball.life_points == initial_life - 1
    assert is_destroyed == False

def test_ball_take_damage_destroyed():
    ball = Ball(100, 50, 20)
    ball.life_points = 1
    is_destroyed = ball.take_damage()
    assert is_destroyed == True

def test_ball_decale():
    ball = Ball(100, 50, 20)
    initial_x = ball.rect.x
    ball.decale(10)
    assert ball.rect.x == initial_x + 10

def test_ball_decale_speed_change():
    ball = Ball(100, 50, 20)
    initial_speed = ball.speed_x
    ball.decale(-10)
    assert ball.speed_x != initial_speed

def test_bullet_initialization():
    bullet = Bullet(100, 50)
    assert bullet.rect.x == 100
    assert bullet.rect.y == 50
    assert bullet.speed_y == 10

def test_bullet_update():
    bullet = Bullet(100, 50)
    initial_y = bullet.rect.y
    bullet.update()
    assert bullet.rect.y == initial_y - bullet.speed_y

def test_bullet_kill():
    bullet = Bullet(100, 50)
    bullet.rect.y = -10
    bullet.update()
    assert bullet.alive() == False

def test_player_initialization():
    player = Player()
    assert player.rect.x == 0
    assert player.rect.y == 0
    assert player.speed == PLAYER_SPEED

def test_player_movement():
    player = Player()
    player.rect.x = 50
    player.rect.y = 50
    player.move_left()
    assert player.rect.x == 40
    player.move_right()
    assert player.rect.x == 50
    player.move_up()
    assert player.rect.y == 40
    player.move_down()
    assert player.rect.y == 50

def test_game_initialization():
    game = Game()
    assert game.level == 0
    assert game.player is not None
    assert game.balls is not None
    assert game.bullets is not None
    assert game.all_sprites is not None

def test_game_spawn_ball():
    game = Game()
    initial_ball_count = len(game.balls)
    game.spawn_ball()
    assert len(game.balls) == initial_ball_count + 1

def test_game_shoot():
    game = Game()
    initial_bullet_count = len(game.bullets)
    game.shoot()
    assert len(game.bullets) == initial_bullet_count + 1

def test_ball_update_boundary_collision():
    ball = Ball(0, 50, 20)
    ball.rect.x = -10
    ball.speed_x = -5
    ball.update()
    assert ball.speed_x > 0

def test_ball_update_screen_bottom():
    ball = Ball(100, 1000, 20)
    ball.rect.bottom = SCREEN_HEIGHT + 10
    ball.speed_y = 5
    ball.update()
    assert BALL_TOP_BOUNCE <= ball.speed_y <= BALL_BOTTOM_BOUNCE

def test_ball_update_speed_y():
    ball = Ball(100, 100, 20)
    ball.rect.bottom = SCREEN_HEIGHT - 10
    ball.speed_y = 5
    ball.update()
    assert ball.speed_y == 5 + BALL_SPEED_FALL

def test_ball_take_damage_rendering():
    ball = Ball(100, 50, 20)
    ball.take_damage()
    assert ball.life_points == 19

def test_ball_decale_speed_inversion():
    ball = Ball(100, 50, 20)
    ball.speed_x = 5
    ball.decale(-10)
    assert ball.speed_x < 0

def test_ball_decale_speed_no_inversion():
    ball = Ball(100, 50, 20)
    ball.speed_x = 5
    ball.decale(10)
    assert ball.speed_x > 0

def test_ball_speed_x_range():
    ball = Ball(100, 50, 20)
    assert ball.speed_x >= BALL_SPEED_X and ball.speed_x <= 2 * BALL_SPEED_X

def test_ball_speed_y_range():
    ball = Ball(100, 50, 20)
    assert ball.speed_y >= -2 and ball.speed_y <= 2

def test_game_spawn_ball_multiple():
    game = Game()
    initial_count = len(game.balls)
    for i in range(5):
        game.spawn_ball()
    assert len(game.balls) == initial_count + 5

def test_game_shoot_multiple():
    game = Game()
    initial_count = len(game.bullets)
    for i in range(3):
        game.shoot()
    assert len(game.bullets) == initial_count + 3

def test_player_movement_boundaries():
    player = Player()
    player.rect.x = 0
    player.move_left()
    assert player.rect.x == 0
    player.rect.x = SCREEN_WIDTH - 10
    player.move_right()
    assert player.rect.x == SCREEN_WIDTH - 10
    player.rect.y = 0
    player.move_up()
    assert player.rect.y == 0
    player.rect.y = SCREEN_HEIGHT - 10
    player.move_down()
    assert player.rect.y == SCREEN_HEIGHT - 10

def test_ball_initialization_with_different_values():
    ball = Ball(100, 50, 30, 2, RED)
    assert ball.rect.x == 100
    assert ball.rect.y == 50
    assert ball.radius == 30
    assert ball.level() == 2

def test_ball_update_edge_case():
    ball = Ball(0, 0, 20)
    ball.rect.left = 0
    ball.rect.right = SCREEN_WIDTH
    ball.speed_x = 5
    ball.update()
    assert ball.speed_x < 0

def test_game_initialization_with_mocked_components():
    with patch('pygame.sprite.Group') as mock_group:
        mock_group_instance = MagicMock()
        mock_group.return_value = mock_group_instance
        game = Game()
        assert game.all_sprites is not None

def test_ball_take_damage_multiple():
    ball = Ball(100, 50, 20)
    for i in range(5):
        ball.take_damage()
    assert ball.life_points == 15

def test_ball_decale_multiple():
    ball = Ball(100, 50, 20)
    ball.decale(10)
    ball.decale(5)
    assert ball.rect.x == 115

def test_bullet_kill_after_screen_top():
    bullet = Bullet(100, 50)
    bullet.rect.y = -10
    bullet.update()
    assert not bullet.alive()

def test_player_movement_with_boundaries():
    player = Player()
    player.rect.x = 0
    player.move_left()
    assert player.rect.x == 0
    player.rect.x = SCREEN_WIDTH - 10
    player.move_right()
    assert player.rect.x <= SCREEN_WIDTH
