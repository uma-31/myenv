class ConfigParsingError(Exception):
    __reason: str

    def __init__(self, reason: str) -> None:
        self.__reason = reason

    @property
    def reason(self) -> str:
        return self.__reason
