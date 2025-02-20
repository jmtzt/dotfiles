#!/usr/bin/env bash

# # Detects if iTerm2 is running
# if ! pgrep -f "ghostty" > /dev/null 2>&1; then
#     open -a "/Applications/Ghostty.app"
# else
#     # Create a new window
#     script='tell application "Ghostty" to create window with default profile'
#     ! osascript -e "${script}" > /dev/null 2>&1 && {
#         # Get pids for any app with "iTerm" and kill
#         while IFS="" read -r pid; do
#             kill -15 "${pid}"
#         done < <(pgrep -f "ghostty")
#         open -a "/Applications/Ghostty.app"
#     }
# fi

# Check if "Ghostty" is running
# if ! pgrep -f "Ghostty" > /dev/null 2>&1; then
#     # Launch the application if not running
#     open -a "/Applications/Ghostty.app"
# else
#     # Attempt to create a new window using AppleScript
#     script='tell application "Ghostty" to create window with default profile'
#     if ! osascript -e "${script}" > /dev/null 2>&1; then
#         echo "Failed to create a new window. Restarting Ghostty..."
#         # Kill all "Ghostty" processes and relaunch
#         pkill -f "Ghostty"
#         open -a "/Applications/Ghostty.app"
#     fi
# fi
# #!/usr/bin/env bash

APP_NAME="Ghostty"
APP_PATH="/Applications/Ghostty.app"

# Function to create a new window using AppleScript
create_new_window() {
    osascript -e 'tell application "'"${APP_NAME}"'" to create window with default profile'
}

# Check if the application is running
if ! pgrep -f "${APP_NAME}" > /dev/null 2>&1; then
    echo "Launching ${APP_NAME}..."
    open -a "${APP_PATH}" || {
        echo "Failed to launch ${APP_NAME}. Please verify the application path or permissions."
        exit 1
    }
else
    echo "${APP_NAME} is already running. Attempting to create a new window..."
    if ! create_new_window > /dev/null 2>&1; then
        echo "Failed to create a new window. Restarting ${APP_NAME}..."
        # Gracefully terminate the app and reopen it
        pkill -f "${APP_NAME}"
        sleep 1
        open -a "${APP_PATH}" || {
            echo "Failed to restart ${APP_NAME}. Please verify the application path or permissions."
            exit 1
        }
    fi
fi
