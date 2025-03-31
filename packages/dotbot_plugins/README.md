# Dotbot Plugins

This directory contains my custom Dotbot plugins.

## Plugins

### Git Clone

Clone git repositories.

#### Format

Git clone plugins specified as a list of dictionaries with the following parameters.

| Parameter | Explanation                                                                          |
| --------- | ------------------------------------------------------------------------------------ |
| `repo`    | Remote repository name or URL. If specified as a name, it will be GitHub repository. |
| `dir`     | Directory to clone.                                                                  |

#### Example

```yaml
- git-clone:
    - repo: uma-31/myenv
      dir: ~/.myenv
```

### Package Install

Install packages. This plugin supports apt-get and brew.

#### Format

| Parameter           | Explanation                                                                                                                                           |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `pkgs`              | List of packages to install. Package manager is automatically detected by OS.                                                                         |
| `apt-get-only-pkgs` | List of packages to install only by apt-get. (optional)                                                                                               |
| `brew-only-pkgs`    | List of packages to install only by brew. (optional)                                                                                                  |
| `priority`          | Priority of package manager. If both apt-get and brew are available, the plugin will use the package manager with higher priority. (default: apt-get) |

#### Example

```yaml
- pkg-install:
    pkgs:
      - jq
      - vim
    apt-get-only-pkgs:
      - zsh
    priority: apt-get
```
