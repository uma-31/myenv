import subprocess

from pathlib import Path


def clone(repo: str, dir: str) -> bool:
    repo_url: str

    if repo.startswith("https://"):
        repo_url = repo
    else:
        repo_url = f"https://github.com/{repo}"

    dir_path = Path(dir).expanduser().resolve()

    if dir_path.exists():
        return False

    subprocess.run(
        ["git", "clone", repo_url, str(dir_path)],
        stderr=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        check=True,
    )
    return True
