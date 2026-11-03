from typing import Any

def text_stats(text: Any) -> dict:
    # Returns stats by given text
    if not isinstance(text, str):
        raise TypeError("text must be a string")

    words = [w.strip(".,!?;:()\"'") for w in text.split()]
    words = [w for w in words if w]

    return {
        "characters": len(text),
        "words": len(words),
        "unique_words": len({w.lower() for w in words}),
        "longest_word": max(words, key=len) if words else "",
    }
