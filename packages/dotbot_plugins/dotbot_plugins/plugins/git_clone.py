from typing import List, TypedDict, cast

from dotbot.context import Context

from .base import DotbotPluginBase
from ..utils import git
from ..config_parsers import BaseConfigParser, DictParser, ListParser, StrParser


class _GitCloneConfigElement(TypedDict):
    repo: str
    dir: str


_GitCloneConfig = List[_GitCloneConfigElement]


class GitClone(DotbotPluginBase[_GitCloneConfig]):
    def __init__(self, context: Context):
        super().__init__(
            "git-clone",
            ListParser(
                cast(
                    BaseConfigParser[_GitCloneConfigElement],
                    DictParser({"repo": StrParser(), "dir": StrParser()}),
                )
            ),
            context,
        )

    def handle_directive(self, data: _GitCloneConfig) -> bool:
        error_occurred = False

        for element in data:
            repo = element["repo"]
            dir = element["dir"]

            self.logger.info(f"Cloning '{repo}' to '{dir}'...")

            try:
                cloned = git.clone(repo, dir)
            except Exception:
                self.logger.error(f"Failed to clone '{repo}'")
                error_occurred = True
                continue

            if cloned:
                self.logger.info(f"Successfully cloned '{repo}'!")
            else:
                self.logger.info(f"Skip cloning '{repo}' (already cloned)")

        return not error_occurred
