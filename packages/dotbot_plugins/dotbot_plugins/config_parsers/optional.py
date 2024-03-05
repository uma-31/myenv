from typing import Any, Generic, TypeVar, Union

from .base import BaseConfigParser

T = TypeVar("T")


class OptionalParser(Generic[T], BaseConfigParser[Union[T, None]]):
    __child_parser: BaseConfigParser[T]

    def __init__(self, child_parser: BaseConfigParser[T]) -> None:
        super().__init__()

        if child_parser.has_default:
            raise ValueError("Optional field cannot have default value")

        self.__child_parser = child_parser

    def validate(self, data: Any) -> None:
        if data is None:
            return

        self.__child_parser.validate(data)

    def parse(self, data: Any) -> Union[T, None]:
        if data is None:
            return None

        return self.__child_parser.parse(data)
