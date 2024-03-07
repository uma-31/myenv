import subprocess

from dotbot.context import Context  # type: ignore
from typing import Dict, List, Literal, TypedDict, Union

from ..utils import cmd
from ..config_parsers import (
    DictParser,
    EnumParser,
    ListParser,
    OptionalParser,
    StrParser,
)
from .base import DotbotPluginBase


_PkgManager = Literal["apt-get", "brew"]


class _PkgInstallConfig(TypedDict):
    pkgs: List[str]
    apt_get_only_pkgs: Union[List[str], None]
    brew_only_pkgs: Union[List[str], None]
    priority: _PkgManager


class PkgInstall(DotbotPluginBase[_PkgInstallConfig]):
    def __init__(self, context: Context):
        super().__init__(
            "pkg-install",
            DictParser(
                {
                    "pkgs": ListParser(StrParser()),
                    "apt_get_only_pkgs": OptionalParser(ListParser(StrParser())),
                    "brew_only_pkgs": OptionalParser(ListParser(StrParser())),
                    "priority": EnumParser(["apt-get", "brew"], default="apt-get"),
                }
            ),
            context,
        )

    def __setup_pkg_manager(self, pkg_manager: _PkgManager) -> bool:
        if pkg_manager == "apt-get":
            result = subprocess.run(["sudo", "apt-get", "-qq", "-y", "update"])
        elif pkg_manager == "brew":
            result = subprocess.run(["brew", "update", "-q"])
        else:
            raise ValueError(f"Unknown package manager: {pkg_manager}")

        return result.returncode == 0

    def __install_pkg(self, pkg_manager: _PkgManager, pkg: str) -> bool:
        if pkg_manager == "apt-get":
            result = subprocess.run(["sudo", "apt-get", "-qq", "-y", "install", pkg])
        elif pkg_manager == "brew":
            result = subprocess.run(["brew", "install", "-q", pkg])
        else:
            raise ValueError(f"Unknown package manager: {pkg_manager}")

        return result.returncode == 0

    def handle_directive(self, data: _PkgInstallConfig) -> bool:
        exists_apt_get = cmd.exists("apt-get")
        exists_brew = cmd.exists("brew")

        priority_pkg_manager: _PkgManager

        if exists_apt_get and exists_brew:
            priority_pkg_manager = data["priority"]
        elif exists_apt_get:
            priority_pkg_manager = "apt-get"
        elif exists_brew:
            priority_pkg_manager = "brew"
        else:
            self.logger.error(f"{self.name} needs 'apt' or 'brew' to install packages")
            return False

        pkg_manager_to_pkgs: Dict[_PkgManager, List[str]] = {}

        if "pkgs" in data:
            pkg_manager_to_pkgs[priority_pkg_manager] = data["pkgs"]

        if (
            exists_apt_get
            and "apt_get_only_pkgs" in data
            and data["apt_get_only_pkgs"] is not None
        ):
            if "apt-get" in pkg_manager_to_pkgs:
                pkg_manager_to_pkgs["apt-get"].extend(data["apt_get_only_pkgs"])
            else:
                pkg_manager_to_pkgs["apt-get"] = data["apt_get_only_pkgs"]

        if (
            exists_brew
            and "brew_only_pkgs" in data
            and data["brew_only_pkgs"] is not None
        ):
            if "brew" in pkg_manager_to_pkgs:
                pkg_manager_to_pkgs["brew"].extend(data["brew_only_pkgs"])
            else:
                pkg_manager_to_pkgs["brew"] = data["brew_only_pkgs"]

        for pkg_manager in pkg_manager_to_pkgs.keys():
            self.logger.info(f"Setting up '{pkg_manager}'...")

            if self.__setup_pkg_manager(pkg_manager):
                self.logger.info(f"Successfully set up '{pkg_manager}'!")
            else:
                self.logger.error(f"Failed to set up '{pkg_manager}'")
                return False

        error_occurred = False

        for pkg_manager, pkgs in pkg_manager_to_pkgs.items():
            for pkg in pkgs:
                self.logger.info(f"Installing '{pkg}' with '{pkg_manager}'...")

                if self.__install_pkg(pkg_manager, pkg):
                    self.logger.info(
                        f"Successfully installed '{pkg}' with '{pkg_manager}'!"
                    )
                else:
                    self.logger.error(f"Failed to install '{pkg}' with '{pkg_manager}'")
                    error_occurred = True

        return not error_occurred
