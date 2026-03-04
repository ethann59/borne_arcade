import pytest
from osu.game import play_map
from osu.config import SCREEN_WIDTH, SCREEN_HEIGHT, BACKGROUND_COLOR
from osu.map_parser import parse_osu_file

def test_parse_osu_file_basic():
    with open("tests/test_osu.osu", "r") as f:
        osu_data = f.readlines()
    parsed_notes = parse_osu_file("tests/test_osu.osu")
    assert len(parsed_notes) == 2
    assert parsed_notes[0]["time"] == 1000
    assert parsed_notes[0]["lane"] == 0
    assert parsed_notes[1]["time"] == 2000
    assert parsed_notes[1]["lane"] == 1

def test_parse_osu_file_empty():
    with open("tests/empty_osu.osu", "w") as f:
        f.write("")
    parsed_notes = parse_osu_file("empty_osu.osu")
    assert len(parsed_notes) == 0

def test_parse_osu_file_no_hit_objects():
    with open("tests/no_hit_objects.osu", "w") as f:
        f.write("[Start]\n[Filename] test.osu\n[TimeSig] 4/4\n[Beat] 1/4\n")
    parsed_notes = parse_osu_file("no_hit_objects.osu")
    assert len(parsed_notes) == 0

def test_play_map_success():
    # Mock the play_map function
    play_map.play_map = lambda beatmap: "success"
    result = play_map("test_osu.osu")
    assert result == "success"

def test_play_map_quit():
    # Mock the play_map function
    play_map.play_map = lambda beatmap: "quit"
    result = play_map("test_osu.osu")
    assert result == "quit"

def test_play_map_invalid_beatmap():
    # Mock the play_map function
    play_map.play_map = lambda beatmap: "error"
    result = play_map("invalid_beatmap.osu")
    assert result == "error"

def test_config_screen_width():
    assert SCREEN_WIDTH == 800

def test_config_screen_height():
    assert SCREEN_HEIGHT == 600

def test_config_background_color():
    assert BACKGROUND_COLOR == (20, 20, 60)
