#!/bin/bash

# date code 1751
# date December 7, 2017
# updated on 1817
# date April 24, 2018
# version 3.3


# check where this script is
where=$( pwd | rev | cut -c1-5 | rev )
if [ "${where/arts}" = "$where" ]; then
	echo "this should be in your parts folder"
	exit
fi


echo
echo "WARNING this will add self destruct line to every .cfg file in its directory"
echo "this shell script should be in a parts folder"
echo
echo "are you sure you want to do this?"
echo "[y,n]"

read input1
if [[ $input1 == "y" || $input1 == "Y" ]]; then

	echo "Loading..."
	# its a verry cheap way of doing this, but it works :)
	file_counter=1
	max_files=$( find . | grep '.cfg$' | cut -c3- | sort | wc -l )
	# give some time to make it feel like its good quality :)
	sleep 2s
	if [[ "$max_files" -eq "0" ]]; then 
		echo 
		echo "theres no .cfg files to edit. make sure this is in your parts folder"
		exit
	fi
	find . | grep '.cfg$' | cut -c3- | sort
	echo
	echo "$max_files files"
	echo
	echo "dose this look right?"
	echo "[y,n]"
	read input2
	if [[ $input2 == "y" || $input2 == "Y" ]]; then

		echo
		echo "Loading..."
		# some extra time here to!
		sleep 2.5s
		for (( e=1; e <= $max_files; e++ )) do
			# notice were do'in a find every time its writing to a .cfg file, not ideal
			file_location=$( find . | grep '.cfg$' | head -$file_counter | tail -1 | cut -c3- )
			# check if the module allready exist
			mod_check=$( cat $file_location | grep 'TacSelfDestruct' )
			echo $file_counter
			echo $file_location
			echo
			if [ -z "$mod_check" ]; then
				# echo the module to the .cfg file
				echo "
	
	MODULE {
	  name = TacSelfDestruct
	  timeDelay = 10.0
	  canStage = false
  }

  " >> $file_location
  # you can modify this as you need, eg. "canStage = true" insted of false
  		((file_counter ++))
		else
			echo "  ^already has module"
			echo
			((file_counter ++))
		fi
	done

	echo
	echo "done"
else 
	echo "okay"
	exit
fi

else
	echo "your loss"
	exit
fi


#
# ChangeLog:
#

# --version_3.3-- cfg_editor_v3.3.sh
# now detects where it is and wont run if its not in a parts folder

# --version_3.2-- cfg_editor_v3.2.sh
# added no cfg file exit

# --version_3.1-- cfg_editor_v3.1.sh
#  first public release



# End ChangeLog


