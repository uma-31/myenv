import subprocess

from dotbot.context import Context  # type: ignore
from typing import List, TypedDict


from .base import DotbotPluginBase
from ..utils import cmd, git
from ..config_parsers import (
    BoolParser,
    DictParser,
    ListParser,
    StrParser,
)


class _AnyenvInstallConfig(TypedDict):
    setup_anyenv: bool
    anyenvs: List[str]


class AnyenvInstall(DotbotPluginBase[_AnyenvInstallConfig]):
    def __init__(self, context: Context):
        super().__init__(
            "anyenv-install",
            DictParser(
                {
                    "setup_anyenv": BoolParser(default=True),
                    "anyenvs": ListParser(StrParser()),
                }
            ),
            context,
        )

    def handle_directive(self, data: _AnyenvInstallConfig) -> bool:
        if not cmd.exists("anyenv"):
            if not data["setup_anyenv"]:
                self.logger.error(
                    "Missing anyenv. Set 'setup_anyenv' to 'true' to install anyenv."
                )
                return False

            self.logger.info("Installing anyenv...")

            try:
                anyenv_cloned = git.clone("anyenv/anyenv", "~/.anyenv")
                anyenv_install_cloned = git.clone(
                    "anyenv/anyenv-install", "~/.config/anyenv/anyenv-install"
                )
            except Exception:
                self.logger.error("Failed to install anyenv. Aborting...")
                return False

            if not anyenv_cloned:
                self.logger.info("Skip installing anyenv (already installed)")
            if not anyenv_install_cloned:
                self.logger.info("Skip installing anyenv-install (already installed)")

            if anyenv_cloned or anyenv_install_cloned:
                self.logger.info("Successfully installed anyenv!")

        error_occurred = False

        for anyenv in data["anyenvs"]:
            self.logger.info(f"Installing {anyenv}...")

            try:
                subprocess.run(
                    f"~/.anyenv/bin/anyenv install --skip-existing {anyenv}",
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                    shell=True,
                    check=True,
                )
            except Exception:
                self.logger.error(f"Failed to install {anyenv}")
                error_occurred = True
                continue

            self.logger.info(f"Succesfully installed {anyenv}!")

        return not error_occurred
