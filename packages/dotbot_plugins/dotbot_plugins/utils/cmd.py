import subprocess


def exists(cmd: str) -> bool:
    result = subprocess.run(
        f"command -v {cmd}",
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        shell=True,
    )
    return result.returncode == 0
