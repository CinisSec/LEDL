#!/bin/bash
#LEDL - Local Entertainment Downloader

#FUNCTIONS SECTION START
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
	read -p "Which movie do you wish to download?: " input
}
function newSeriesList() {
	echo "This is a list of series you haven't watched yet:"
	echo ""
	ls /Volumes/Data/Shared/series/__new_series
	read -p "Which series do you want to download?: " input
}
function newMovieDownload() {
	if [ -d ~/Movies/"$input" ]; then
		echo "Destination directory already exists downloading non-exsiting files..."
		rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/movies/__new_movies/*"$input"* ~/Movies/"$input"
	else
		echo "Creating download directory..."
		mkdir ~/Movies/"$input"/
		rsync -avz -r --progress /Volumes/Data/Shared/movies/__new_movies/*"$input"* ~/Movies/"$input"
	fi
}
function newSeriesDownload() {
	if [ -d ~/Movies/"$input" ]; then
		echo "Destination directory already exists downloading non-exsiting files..."
		rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/series/__new_series/*"$input"* ~/Movies/"$input"
	else
		echo "Creating download directory..."
		mkdir ~/Movies/"$input"/
		rsync -avz -r --progress /Volumes/Data/Shared/series/__new_series/*"$input"* ~/Movies/"$input"
	fi
}
#FUNCTIONS SECTION END

#MAIN SECTION START
if [ -d "/Volumes/Data/Shared" ]; then
	categoryChoice
	if [[ "$category" == "1" ]]; then
		newMoviesList
		if [[ "$input" == "q" ]]; then
			echo "Quitting..."
		else
			newMovieDownload
		fi
	elif [[ "$category" == "2" ]]; then
		newSeriesList
		if [[ "$input" == "q" ]]; then
			echo "Quitting..."
		else
			newSeriesDownload
		fi
	fi
else
	echo "Volume is not mounted"
fi
#MAIN SECTION END
