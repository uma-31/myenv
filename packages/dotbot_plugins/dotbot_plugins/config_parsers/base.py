from typing import Any, TypeVar, Union, Generic

from .error import ConfigParsingError

T = TypeVar("T")


class BaseConfigParser(Generic[T]):
    __default: Union[T, None]

    def __init__(self, default: Union[T, None] = None) -> None:
        self.__default = default

    @property
    def has_default(self) -> bool:
        return self.__default is not None

    def apply_default(self, data: Any) -> Any:
        if data is None and self.has_default:
            return self.__default
        return data

    def validate(self, data: Any) -> None:
        if data is None:
            raise ConfigParsingError("This field is required, but not specified")

    def parse(self, data: Any) -> T:
        d = self.apply_default(data)
        self.validate(d)
        return d
