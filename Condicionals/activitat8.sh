#!/bin/bash
arxiu=$1
extension=$arxiu

if [[ -d $arxiu  ]]; then
        echo "$arxiu es un directori"

elif [[ -f $arxiu  ]]; then
        echo "$arxiu es un fitxer y la seva extensió és ${extension#*.}"

else
	echo "Error: $arxiu no es un fitxer o directori"
fi





