# This script is used to list available display resolutions and generate Alfred results for resolution changes.
# It takes an optional argument for filtering the results based on width or height.
# The script uses the RDM (Retina Display Menu) command-line tool to retrieve display information.
# The results are formatted as XML and outputted to be consumed by Alfred.
# Each result item includes the display number, resolution, frequency, and a subtitle for changing the resolution.
# The script supports case-insensitive matching for the search argument.
# The icon.png file is used as the icon for each result item.

#Working Directory
WFWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RDMWD="$(cd "$(dirname "/Applications/RDM.app/Contents/MacOS/RDM")" && pwd)"

#Case-insensitive matching
shopt -s nocasematch

search="$1" #Alfred argument

# Get modes for each display
modes=""
dislays=$($RDMWD/RDM -l)
n_displays=$(echo "$dislays" | wc -l)
for ((i = 0; i < n_displays; i++)); do
	ms="$($RDMWD/RDM -m -d $i -s 2)"
	while IFS= read -r line; do
		# add display number to the end of each mode
		modes+="$line$i"$'\n'
	done <<<"$ms"
done

#Populate Alfred results
echo '<?xml version="1.0"?>
	<items>'

while IFS= read -r line; do
	# Extract width, height, frequency, and display number from mode
	if [[ $line =~ resolution=([0-9]+)x([0-9]+),.*freq[[:space:]]=[[:space:]]([0-9]+) ]]; then
		width=${BASH_REMATCH[1]}
		height=${BASH_REMATCH[2]}
		freq=${BASH_REMATCH[3]}
		display="${line: -1}"

		# Filter results based on search argument and frequency over 60hz
		if [[ (-z "$search" || "$width" == "$search"* || "$height" == "$search"*) && $freq -ge 60 ]]; then

			# Generate Alfred result item which sends when selected width|height|display to the next script in the pipeline
			echo '<item uid="code" arg="'$width'|'$height'|'$display'" valid="yes">
      <title>'${display}:${freq}hz $width' x '$height'</title>
      <subtitle>Change resolution display '$display' to '$width' x '$height'</subtitle>
      <icon>icon.png</icon>
      </item>'

		fi
	fi
done <<<"$modes"

echo '</items>'

IFS=$OLD_IFS
exit
