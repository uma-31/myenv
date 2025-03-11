from abc import ABC, abstractmethod
from typing import Any, TypeVar, Generic

from dotbot import Plugin
from dotbot.context import Context
from dotbot.messenger import Messenger

from ..config_parsers import BaseConfigParser, ConfigParsingError

T = TypeVar("T")


class _LoggerWrapper:
    __name: str
    __logger: Messenger

    def __init__(self, name: str, logger: Messenger) -> None:
        self.__name = name
        self.__logger = logger

    @property
    def name(self) -> str:
        return self.__name

    def info(self, message: str) -> None:
        self.__logger.info(f"[{self.name}] {message}")

    def warn(self, message: str) -> None:
        self.__logger.warning(f"[{self.name}] {message}")

    def error(self, message: str) -> None:
        self.__logger.error(f"[{self.name}] {message}")


class DotbotPluginBase(ABC, Generic[T], Plugin):
    __directive: str
    __config_parser: BaseConfigParser[T]
    __logger: _LoggerWrapper

    def __init__(
        self,
        directive: str,
        config_parser: BaseConfigParser[T],
        context: Context,
    ):
        super().__init__(context)

        self.__directive = directive
        self.__config_parser = config_parser
        self.__logger = _LoggerWrapper(self.name, self._log)

    @property
    def name(self) -> str:
        return self.__class__.__name__

    @property
    def directive(self) -> str:
        return self.__directive

    @property
    def config_parser(self) -> BaseConfigParser[T]:
        return self.__config_parser

    @property
    def logger(self) -> _LoggerWrapper:
        return self.__logger

    def can_handle(self, directive: str) -> bool:
        if not self.directive == directive:
            return False
        return True

    @abstractmethod
    def handle_directive(self, data: T) -> bool: ...

    def handle(self, directive: str, data: Any) -> bool:
        if not self.can_handle(directive):
            raise ValueError(f"{self.name} cannot handle directive {directive}")

        try:
            parsed_data = self.config_parser.parse(data)
        except ConfigParsingError as e:
            error_prefix = "Failed to parse install config for the following reasons:"

            if "\n" in e.reason:
                sep = "\n"
            else:
                sep = " "

            self.logger.error(error_prefix + sep + e.reason)

            return False

        self.handle_directive(parsed_data)

        return True
