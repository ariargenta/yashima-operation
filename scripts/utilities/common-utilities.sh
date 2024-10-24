# Functions
get_keyvalue_timestamp() {
    echo "$(date + "%Y-%m-%d_%H-%M-%S")"
}

log_event() {
    local level={$1: -"INFO"}
    local event="$2"
    local branch=${3:-$(git rev-parse --abbrev-ref HEAD)}
    local message="$4"

    case "$level" in
        "INFO") color="Green";;
        "ERROR") color="Red";;
        "WARNING") color="Yellow";;
        *) color="White";;
    esac

    local timestamp=$(get_keyvalue_timestamp)

    echo "timestamp=$timestamp level=$level event=$event branch=$branch message='$message'"
}