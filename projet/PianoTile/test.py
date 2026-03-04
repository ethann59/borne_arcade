import pytest
import pygame
from core.button import Button
from core.logic import Logic
from core.player import Player
from ui.layout.gameView import GameView
from ui.layout.timerView import TimerView
from ui.utils.color import Color
from core.pageState import PageState

class MockGameView:
    def __init__(self):
        self.windowManager = MockWindowManager()
        self.page = PageState.ACCUEIL
        self.pagePrecedente = PageState.PROFIL
        self.selection = MockSelection()

    def setUpdate(self, value):
        pass

    def setPage(self, page):
        self.page = page

    def getWindowManager(self):
        return self.windowManager

    def getSelection(self):
        return self.selection

    def getGame(self):
        return MockGame()

class MockWindowManager:
    def __init__(self):
        self.selection = None

    def getSelection(self):
        return self.selection

    def setSelection(self, selection):
        self.selection = selection

class MockSelection:
    def __init__(self):
        self.position = 0
        self.selection = []

    def updatePosition(self, position):
        self.position = position

    def getSelection(self):
        return self.selection

    def getPosition(self):
        return self.position

class MockGame:
    def getDatabase(self):
        return MockDatabase()

class MockDatabase:
    def getPlayers(self):
        return [(1, "user1", "password1"), (2, "user2", "password2")]

class TestLogic:
    def test_logic_initialization(self):
        logic = Logic(MockGame())
        assert logic.getColor() is not None
        assert logic.getButton() is not None
        assert logic.getInterface() is not None

    def test_logic_get_color(self):
        logic = Logic(MockGame())
        color = logic.getColor()
        assert color is not None

    def test_logic_get_button(self):
        logic = Logic(MockGame())
        button = logic.getButton()
        assert button is not None

    def test_logic_action_page_profil(self):
        logic = Logic(MockGame())
        logic.actionPageProfil()
        assert logic.getInterface().getPage() == PageState.PROFIL
        assert logic.getInterface().getUpdate() == True

    def test_logic_action_page_inscription(self):
        logic = Logic(MockGame())
        logic.actionPageInscription()
        assert logic.getInterface().getPage() == PageState.ACCUEIL
        assert logic.getInterface().getUpdate() == True

    def test_logic_get_button_update(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction == "enter"

    def test_logic_get_button_no_update(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_tuple_update(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert isinstance(direction, tuple)

    def test_logic_get_button_tuple_update_position(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert isinstance(direction, tuple)

    def test_logic_get_button_no_update_none(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_2(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_3(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_4(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_5(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_6(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_7(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_8(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_9(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_10(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_11(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_12(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_13(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_14(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_15(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_16(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_17(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_18(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_19(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_20(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_21(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_22(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_23(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_24(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    def test_logic_get_button_no_update_none_25(self):
        button = Button()
        direction = button.update(pygame.KEYDOWN)
        assert direction is None

    def test_logic_get_button_no_update_none_26(self):
        button = Button()
        direction = button.update(pygame.QUIT)
        assert direction is None

    