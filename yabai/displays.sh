#!/bin/bash

# Get the list of all displays and their spaces
DISPLAYS=$(yabai -m query --displays)

# Parse and loop through the displays
for DISPLAY in $(echo "$DISPLAYS" | jq -r '.[] | @base64'); do
    _jq() {
        echo ${DISPLAY} | base64 --decode | jq -r ${1}
    }

    DISPLAY_UUID=$(_jq '.uuid')    # Get the UUID of the display
    SPACES=$(_jq '.spaces')        # Get the list of spaces for the display

    # Set padding for each space on the current display
    for SPACE_INDEX in $(echo "$SPACES" | jq -r '.[]'); do
        echo "Setting padding for space $SPACE_INDEX on display $DISPLAY_UUID"

        # Set padding based on display UUID (you can adjust the values)
        if [ "$DISPLAY_UUID" == "37D8832A-2D66-02CA-B9F7-8F30A301B230" ]; then
            # Display with UUID 37D8832A-2D66-02CA-B9F7-8F30A301B230 (Space 1-5)
            yabai -m config --space "$SPACE_INDEX" top_padding 6
        elif [ "$DISPLAY_UUID" == "A947314F-91FE-47DB-A23E-A95FC4BB279A" ]; then
            # Display with UUID A947314F-91FE-47DB-A23E-A95FC4BB279A (Space 6)
            yabai -m config --space "$SPACE_INDEX" top_padding 36
        elif [ "$DISPLAY_UUID" == "460C1FF0-4BDD-4884-A351-25D48F9F4632" ]; then
            # Display with UUID 460C1FF0-4BDD-4884-A351-25D48F9F4632 (Space 7)
            yabai -m config --space "$SPACE_INDEX" top_padding 36
        fi
    done
done
