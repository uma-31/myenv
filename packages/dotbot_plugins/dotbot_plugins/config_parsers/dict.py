from typing import Any, Dict, Generic, TypeVar, cast

from .base import BaseConfigParser
from .error import ConfigParsingError

from ..utils import string

T = TypeVar("T")

_AnyDict = Dict[str, Any]
_ValueParsers = Dict[str, BaseConfigParser[Any]]


class DictParser(Generic[T], BaseConfigParser[T]):
    def __init__(self, value_parsers: _ValueParsers) -> None:
        super().__init__()

        self.__value_parsers = value_parsers

    def __py_key_to_conf_key(self, key: str) -> str:
        return key.replace("_", "-")

    def __conf_key_to_py_key(self, key: str) -> str:
        return key.replace("-", "_")

    def apply_default(self, data: Any) -> Any:
        if not isinstance(data, dict):
            return data

        applied: _AnyDict = {}

        for py_key, parser in self.__value_parsers.items():
            conf_key = self.__py_key_to_conf_key(py_key)

            applied[conf_key] = parser.apply_default(
                data[conf_key] if conf_key in data else None
            )

        return applied

    def validate(self, data: Any) -> None:
        super().validate(data)

        if not isinstance(data, dict):
            got_type_name = type(data).__name__

            raise ConfigParsingError(
                f"This field must be a dictionary (got {got_type_name})"
            )

        has_error = False
        error_reason = ""

        def add_error_reason(key: str, reason: str) -> None:
            nonlocal has_error, error_reason

            has_error = True
            error_reason += f"- Field '{key}' was invalid for the following reasons\n"
            error_reason += string.indent(
                f"{reason}\n" if reason.startswith("-") else f"- {reason}\n",
            )

        for py_key in self.__value_parsers.keys():
            conf_key = self.__py_key_to_conf_key(py_key)

            if py_key not in self.__value_parsers:
                add_error_reason(conf_key, "Unrecognized field")
                continue

            try:
                self.__value_parsers[py_key].validate(data[conf_key])
            except ConfigParsingError as e:
                add_error_reason(conf_key, e.reason)

        if has_error:
            raise ConfigParsingError(error_reason)

    def parse(self, data: Any) -> T:
        default_applied = self.apply_default(data)

        self.validate(default_applied)

        converted_data: _AnyDict = {}

        for conf_key, value in cast(_AnyDict, default_applied).items():
            py_key = self.__conf_key_to_py_key(conf_key)

            converted_data[py_key] = value

        return cast(T, converted_data)
