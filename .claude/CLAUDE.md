# myenv - Personal Development Environment

## What This Is

A **chezmoi-managed repository** for automated cross-platform development environment setup.

One-command installation deploys:

- Dotfiles
- Shell environment (zsh + zplug)
- Development tools (managed by mise)
- System packages

## Package Management

Edit [requirements.yaml](.chezmoidata/requirements.yaml) to add/remove packages.
Installation logic: [run_onchange_install-packages.sh.tmpl](.chezmoiscripts/run_onchange_install-packages.sh.tmpl)

## Chezmoi Documentation

### User Guide

- [Setup](https://www.chezmoi.io/user-guide/setup/) - Basic concepts and directory structure
- [Daily Operations](https://www.chezmoi.io/user-guide/daily-operations/) - Common workflows
- [Templating](https://www.chezmoi.io/user-guide/templating/) - Template syntax and usage
- [Use Scripts to Perform Actions](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/) - Script execution
- [Install Packages Declaratively](https://www.chezmoi.io/user-guide/advanced/install-packages-declaratively/) - Package management patterns
- [Manage Machine Differences](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/) - OS-specific configurations
- [Keeper Integration](https://www.chezmoi.io/user-guide/password-managers/keeper/) - Password manager support

### Reference

- [Templates](https://www.chezmoi.io/reference/templates/) - Template functions reference
- [Special Files](https://www.chezmoi.io/reference/special-files/chezmoitemplates/) - `.chezmoitemplates/` usage
- [Special Files](https://www.chezmoi.io/reference/special-files/chezmoidata/) - `.chezmoidata/` usage
- [Special Directories](https://www.chezmoi.io/reference/special-directories/) - Directory structure
- [Commands](https://www.chezmoi.io/reference/commands/) - Command reference
