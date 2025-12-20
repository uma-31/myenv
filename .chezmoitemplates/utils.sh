#shellcheck shell=bash

# shellcheck disable=SC2034
readonly LF=$'\n'

__myenv_log_level_to_number() {
    case "$1" in
        DEBUG) echo 0 ;;
        INFO) echo 1 ;;
        WARN) echo 2 ;;
        ERROR) echo 3 ;;
    esac
}

__myenv_log() {
    local level="$1"
    shift

    local level_num
    level_num=$(__myenv_log_level_to_number "$level")

    local level_threshold_num
    level_threshold_num=$(__myenv_log_level_to_number "${MYENV_LOG_LEVEL:-INFO}")

    if [ "$level_num" -lt "$level_threshold_num" ]; then
        return 0
    fi

    local fd
    case "$level" in
        DEBUG|INFO) fd=1 ;;
        WARN|ERROR) fd=2 ;;
    esac

    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    local color_start=""
    local color_end=""

    if [ -z "${NO_COLOR:-}" ]; then
        case "$level" in
            DEBUG) color_start="\033[0;37m" ;;
            INFO) color_start="\033[0;32m" ;;
            WARN) color_start="\033[0;33m" ;;
            ERROR) color_start="\033[0;31m" ;;
        esac
        color_end="\033[0m"
    fi

    printf "${color_start}%s [%s] %s${color_end}\n" \
        "$timestamp" "$level" "$*" >&"$fd"
}

myenv_log_debug() {
    __myenv_log DEBUG "$*"
}

myenv_log_info() {
    __myenv_log INFO "$*"
}

myenv_log_warn() {
    __myenv_log WARN "$*"
}

myenv_log_error() {
    __myenv_log ERROR "$*"
}
