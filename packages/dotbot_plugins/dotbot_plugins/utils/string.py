def indent(s: str, width: int = 4) -> str:
    return "\n".join(f"{' ' * width}{line}" for line in s.split("\n"))
