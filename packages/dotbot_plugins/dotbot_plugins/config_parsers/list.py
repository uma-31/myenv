from typing import Any, Generic, List, TypeVar, cast

from .base import BaseConfigParser
from .error import ConfigParsingError

from ..utils import string

T = TypeVar("T")


class ListParser(Generic[T], BaseConfigParser[List[T]]):
    __child_parser: BaseConfigParser[T]

    def __init__(self, child_parser: BaseConfigParser[T]) -> None:
        super().__init__()

        if child_parser.has_default:
            raise ValueError("List field cannot have default value")

        self.__child_parser = child_parser

    def validate(self, data: Any) -> None:
        super().validate(data)

        if not isinstance(data, list):
            got_type_name = type(data).__name__

            raise ConfigParsingError(f"This field must be a list (got {got_type_name})")

        has_error = False
        error_reason = ""

        def add_error_reason(index: int, reason: str) -> None:
            nonlocal has_error, error_reason

            has_error = True
            error_reason += (
                f"- Element at index {index} was invalid for the following reasons\n"
            )
            error_reason += string.indent(
                f"{reason}\n" if reason.startswith("-") else f"- {reason}\n"
            )

        for index, element in enumerate(cast(List[Any], data)):
            try:
                self.__child_parser.validate(element)
            except ConfigParsingError as e:
                add_error_reason(index, e.reason)

        if has_error:
            raise ConfigParsingError(error_reason)
