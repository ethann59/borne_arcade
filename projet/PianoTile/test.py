import pytest
from unittest.mock import Mock, patch
from core.logic import Logic
from core.player import Player
from ui.layout.menuView import MenuView
from ui.manager.windowManager import WindowManager
from core.pageState import PageState
from core.button import Button
from ui.utils.color import Color

# Tests de base
def test_logic_initialization():
    game_mock = Mock()
    logic = Logic(game_mock)
    assert logic.getGame() == game_mock
    assert isinstance(logic.getColor(), Color)
    assert isinstance(logic.getButton(), Button)

# Tests fonctionnels
def test_action_page_profil_navigation():
    game_mock = Mock()
    interface_mock = Mock()
    game_mock.getInterface.return_value = interface_mock
    logic = Logic(game_mock)
    
    selection_mock = Mock()
    selection_mock.getSelection.return_value = ([], [["Retour", "Profil", "Se connecter", "S'inscrire", "Accueil", "Multijoueur", "Statistique", "Quitter"]])
    selection_mock.getPosition.return_value = 0
    
    window_manager_mock = Mock()
    window_manager_mock.getSelection.return_value = selection_mock
    interface_mock.getWindowManager.return_value = window_manager_mock
    
    # Simuler un événement "enter" sur "Retour"
    button_mock = Mock()
    button_mock.update.return_value = "enter"
    logic.getButton = lambda: button_mock
    
    logic.actionPageProfil()
    
    interface_mock.setPage.assert_called_with(interface_mock.getPagePrecedente())
    interface_mock.setUpdate.assert_called_with(True)

def test_action_page_inscription_valid_user():
    game_mock = Mock()
    interface_mock = Mock()
    game_mock.getInterface.return_value = interface_mock
    game_mock.getDatabase.return_value = Mock()
    logic = Logic(game_mock)
    
    page_mock = Mock()
    page_mock.input_username.get_text.return_value = "testuser"
    page_mock.input_password.get_text.return_value = "password"
    page_mock.input_confirmPassword.get_text.return_value = "password"
    page_mock.erreur_inscription = False
    
    menu_mock = Mock()
    menu_mock.getPage.return_value = page_mock
    window_manager_mock = Mock()
    window_manager_mock.getMenu.return_value = menu_mock
    interface_mock.getWindowManager.return_value = window_manager_mock
    interface_mock.getPage.return_value = PageState.INSCRIPTION
    
    # Simuler un utilisateur valide
    db_mock = Mock()
    db_mock.getPlayers.return_value = [(1, "testuser", "password")]
    game_mock.getDatabase.return_value = db_mock
    
    # Simuler un événement "enter" sur "Valider"
    button_mock = Mock()
    button_mock.update.return_value = "enter"
    logic.getButton = lambda: button_mock
    
    selection_mock = Mock()
    selection_mock.getSelection.return_value = ([], [["Retour", "Valider", "Profil", "Accueil", "Nom d'utilisateur", "Mot de passe", "Confirmer mot de passe"]])
    selection_mock.getPosition.return_value = 1  # "Valider"
    window_manager_mock.getSelection.return_value = selection_mock
    
    logic.actionPageInscription()
    
    assert page_mock.erreur_inscription == False
    interface_mock.setPage.assert_called_with(PageState.ACCUEIL)
    interface_mock.setUpdate.assert_called_with(True)

def test_action_page_inscription_invalid_user():
    game_mock = Mock()
    interface_mock = Mock()
    game_mock.getInterface.return_value = interface_mock
    logic = Logic(game_mock)
    
    page_mock = Mock()
    page_mock.input_username.get_text.return_value = "testuser"
    page_mock.input_password.get_text.return_value = "password"
    page_mock.input_confirmPassword.get_text.return_value = "wrongpassword"
    page_mock.erreur_inscription = False
    
    menu_mock = Mock()
    menu_mock.getPage.return_value = page_mock
    window_manager_mock = Mock()
    window_manager_mock.getMenu.return_value = menu_mock
    interface_mock.getWindowManager.return_value = window_manager_mock
    interface_mock.getPage.return_value = PageState.INSCRIPTION
    
    # Simuler un événement "enter" sur "Valider"
    button_mock = Mock()
    button_mock.update.return_value = "enter"
    logic.getButton = lambda: button_mock
    
    selection_mock = Mock()
    selection_mock.getSelection.return_value = ([], [["Retour", "Valider", "Profil", "Accueil", "Nom d'utilisateur", "Mot de passe", "Confirmer mot de passe"]])
    selection_mock.getPosition.return_value = 1  # "Valider"
    window_manager_mock.getSelection.return_value = selection_mock
    
    logic.actionPageInscription()
    
    assert page_mock.erreur_inscription == True
    interface_mock.setUpdate.assert_called_with(True)

# Tests de cas limites
def test_action_page_inscription_invalid_page():
    game_mock = Mock()
    interface_mock = Mock()
    game_mock.getInterface.return_value = interface_mock
    logic = Logic(game_mock)
    
    interface_mock.getPage.return_value = PageState.CONNEXION  # Pas INSCRIPTION
    
    logic.actionPageInscription()
    
    # Ne devrait rien faire
    interface_mock.setUpdate.assert_not_called()

def test_action_page_inscription_no_page():
    game_mock = Mock()
    interface_mock = Mock()
    game_mock.getInterface.return_value = interface_mock
    logic = Logic(game_mock)
    
    interface_mock.getPage.return_value = PageState.INSCRIPTION
    
    menu_mock = Mock()
    menu_mock.getPage.return_value = None
    window_manager_mock = Mock()
    window_manager_mock.getMenu.return_value = menu_mock
    interface_mock.getWindowManager.return_value = window_manager_mock
    
    logic.actionPageInscription()
    
    # Ne devrait pas planter
    interface_mock.setUpdate.assert_not_called()

# Tests d'intégration
def test_logic_integration_with_player():
    game_mock = Mock()
    interface_mock = Mock()
    game_mock.getInterface.return_value = interface_mock
    logic = Logic(game_mock)
    
    player = Player(1, "testuser", "password")
    
    window_manager_mock = Mock()
    window_manager_mock.getCurrentUser.return_value = player
    interface_mock.getWindowManager.return_value = window_manager_mock
    
    assert logic.getGame() == game_mock
    assert isinstance(logic.getColor(), Color)
    assert isinstance(logic.getButton(), Button)
