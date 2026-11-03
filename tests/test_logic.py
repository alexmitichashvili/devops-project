import pytest

from app.logic import text_stats


def test_basic_counts():
    result = text_stats("hello world hello")
    assert result["words"] == 3
    assert result["unique_words"] == 2


def test_empty_text():
    result = text_stats("")
    assert result["words"] == 0
    assert result["longest_word"] == ""


def test_longest_word_ignores_punctuation():
    assert text_stats("cat elephant, dog")["longest_word"] == "elephant"


def test_invalid_type_raises():
    with pytest.raises(TypeError):
        text_stats(42)
