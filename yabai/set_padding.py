# import subprocess

# output = subprocess.run(
#     ["yabai", "-m", "query", "--displays"], capture_output=True, text=True
# )
# output_text = bool(output.stdout.strip())
# output_obj = eval(output_text)
# width = output_obj[0]["frame"]["w"]

# if width == 2560.0:
#     subprocess.run(["yabai", "-m", "config", "top_padding", "34"])
#     print("Padding set to 34")
# else:
#     subprocess.run(["yabai", "-m", "config", "top_padding", "6"])
#     print("Padding set to 0")

import json
import subprocess

# Run yabai command to get display information
output = subprocess.run(
    ["yabai", "-m", "query", "--displays"], capture_output=True, text=True
)

# Parse the JSON output
try:
    output_obj = json.loads(output.stdout.strip())

    # Get the width of the first display
    width = output_obj[0]["frame"]["w"]

    # Set padding based on the display width
    if width == 2560.0:
        subprocess.run(["yabai", "-m", "config", "top_padding", "36"])
        print("Padding set to 34")
    else:
        subprocess.run(["yabai", "-m", "config", "top_padding", "6"])
        print("Padding set to 6")

except json.JSONDecodeError:
    print("Error decoding JSON output from yabai.")
except IndexError:
    print("No displays found.")
except KeyError:
    print("Invalid data structure in yabai output.")
