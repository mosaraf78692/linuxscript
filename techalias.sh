#!/bin/bash    


# Search for the file "tech.sh" in the root directory and all subdirectories.
result=$(sudo find / -name "tech.sh" 2>/dev/null)
# Search for the directory "Documentations" in the root directory and all subdirectories.
result1=$(sudo find / -name "Documentations" 2>/dev/null)

if [[ $1 == "--help" ]] || [[ $1 == "?" ]] || [[ $1 == "-h" ]]; then
	# Display the contents of the file found with the name "Documentations".
        cat "$result1"
else
        # Display the result of the file search for "tech.sh".
        $result
fi
