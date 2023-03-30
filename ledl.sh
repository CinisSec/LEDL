#!/bin/bash
#LEDL - Local Entertainment Downloader

function categoryChoice() {
	echo "Which category do you want to download?"
	echo "[1] movies"
	echo "[2] series"
	read -p "Input choice: [1-2]" category
}

function newMoviesList() {
	echo "This is a list of movies you haven't watched yet:"
	echo ""
	ls /Volumes/Data/Shared/movies/__new_movies
	read -p "Which movie do you wish to download?: " ms
}

function newSeriesList() {
	echo "This is a list of series you haven't watched yet:"
	echo ""
	ls /Volumes/Data/Shared/series/__new_series
	read -p "Which series do you want to download?: " ss
}

function newMovieDownload() {
	if [ -d ~/Movies/"$ms" ]; then
		echo "Destination directory already exists downloading non-exsiting files..."
		rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/movies/__new_movies/*"$ms"* ~/Movies/"$ms"
	else
		echo "Creating download directory..."
		mkdir ~/Movies/"$ms"/
		rsync -avz -r --progress /Volumes/Data/Shared/movies/__new_movies/*"$ms"* ~/Movies/"$ms"
	fi
}

function newSeriesDownload() {
	if [ -d ~/Movies/"$ss" ]; then
		echo "Destination directory already exists downloading non-exsiting files..."
		rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/series/__new_series/*"$ss"* ~/Movies/"$ss"
	else
		echo "Creating download directory..."
		mkdir ~/Movies/"$ss"/
		rsync -avz -r --progress /Volumes/Data/Shared/series/__new_series/*"$ss"* ~/Movies/"$ss"
	fi
}


if [ -d "/Volumes/Data/Shared" ]; then
	categoryChoice
	
	#Movie SECTION START
	if [[ "$category" == "1" ]]; then
		newMoviesList
		if [[ "$ms" == "q" ]]; then
			echo "Quitting..."
		else
			newMovieDownload
		fi
	#Movie SECTION END

	#Series SECTION START
	elif [[ "$category" == "2" ]]; then
		newSeriesList
		if [[ "$ss" == "q" ]]; then
			echo "Quitting..."
		else
			newSeriesDownload
		fi
	fi
	#Series SECTION END
else
	echo "Volume is not mounted"
fi
