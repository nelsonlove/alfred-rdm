#Working Directory
WFWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RDMWD="$( cd "$( dirname "/Applications/RDM.app/Contents/MacOS/SetResX" )" && pwd )"
#Case-insensitive matching
shopt -s nocasematch

resolutions_file="$WFWD/resolutions.txt"

search="$1"	#Alfred argument

#Populate Alfred results with Timezones list
echo '<?xml version="1.0"?>
	<items>'

while IFS= read -r line
	do
	OIFS=$IFS
	IFS='|'		#Split stored line by delimiter
	data=($line)	#Create array
	code="${data[0]}"
	name="${data[1]}"
	width="${data[2]}"
	height="${data[3]}"
	scale="${data[4]}"
	IFS=$OIFS

	if [[ "" == "$search" ]] || [[ "$code" == "$search"* ]] || [[ "$name" == "$search"* ]]; then
		echo '<item uid="'$code'" arg="'$width'|'$height'" valid="yes">
		<title>'$code': '$width' x '$height'</title>
		<subtitle>'$name': Change resolution to '$width' x '$height'</subtitle>
		<icon>icon.png</icon>
		</item>'
	fi
	done < "$resolutions_file"
echo '</items>'

IFS=$OLD_IFS
exit
