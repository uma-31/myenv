from typing import Any

from .base import BaseConfigParser
from .error import ConfigParsingError


class StrParser(BaseConfigParser[str]):
    def validate(self, data: Any) -> None:
        super().validate(data)

        if not isinstance(data, str):
            raise ConfigParsingError("This field must be a string")
