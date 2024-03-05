from typing import Any

from .base import BaseConfigParser
from .error import ConfigParsingError


class BoolParser(BaseConfigParser[bool]):
    def validate(self, data: Any) -> None:
        super().validate(data)

        if not isinstance(data, bool):
            got_type_name = type(data).__name__

            raise ConfigParsingError(
                f"This field must be a boolean (got {got_type_name})"
            )
