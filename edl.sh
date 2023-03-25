#EDL - Entertainment Downloader
#!/bin/bash

#Check if folder exists
if [ -d "/Volumes/Data/Shared" ]; then
	echo "Which category do you want to download?"
	echo "[1] movies"
	echo "[2] series"
    read -p "Input choice: [1-2]" category
    #Movie Category START
    if [[ "$category" == "1" ]]; then
	echo "This is a list of movies you haven't watched yet:"
	echo ""	
	ls /Volumes/Data/Shared/movies/__new_movies
	read -p "Which movie do you wish to download?: " ms
	
	if [[ "$ms" == "q" ]]; then
		echo "Quitting..."
	else
		if [ -d ~/Movies/"$ms" ]; then
			echo "Destination directory already exists downloading non-exsiting files..."
			rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/movies/__new_movies/*"$ms"* ~/Movies/"$ms"
		else
			echo "Creating download directory..."
			mkdir ~/Movies/"$ms"/
			rsync -avz -r --progress /Volumes/Data/Shared/movies/__new_movies/*"$ms"* ~/Movies/"$ms"
		fi
	fi
    #Movie Category END
    
    #Series Category START
    elif [[ "$category" == "2" ]]; then
	echo "This is a list of series you haven't watched yet:"
	echo "" 
	ls /Volumes/Data/Shared/series/__new_series
	read -p "Which series do you want to download?: " ss

	if [[ "$ss" == "q" ]]; then
		echo "Quitting..."
	else
		if [ -d ~/Movies/"$ss" ]; then
			echo "Destination directory already exists downloading non-exsiting files..."
			rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/series/__new_series/*"$ss"* ~/Movies/"$ss"
		else
			echo "Creating download directory..."
			mkdir ~/Movies/"$ss"/
			rsync -avz -r --progress /Volumes/Data/Shared/series/__new_series/*"$ss"* ~/Movies/"$ss"
		fi
	fi
    fi
    #Series Category END
else
    echo "Volume is not mounted"
fi


