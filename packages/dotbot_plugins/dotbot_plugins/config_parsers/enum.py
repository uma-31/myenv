from typing import Any, Generic, Iterable, Set, TypeVar, Union

from .str import StrParser
from .error import ConfigParsingError

T = TypeVar("T", bound=str)


class EnumParser(StrParser, Generic[T]):
    __choices: Set[T]

    def __init__(self, choices: Iterable[T], default: Union[T, None] = None) -> None:
        super().__init__(default=default)

        self.__choices = set(choices)

    def validate(self, data: Any) -> None:
        super().validate(data)

        if data not in self.__choices:
            choices = ", ".join(self.__choices)

            raise ConfigParsingError(
                f"This field must be one of {choices} (got '{data}')"
            )
