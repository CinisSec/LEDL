#!/bin/bash
#LEDL - Local Entertainment Downloader

#FUNCTIONS SECTION START
function categoryChoice() {
	echo "Which category do you want to download?"
	echo "[1] movies"
	echo "[2] series"
	read -p "Category choice: [1-2]" category
}
function oldMoviesList() {
	#TODO
}
function newMoviesList() {
	echo "This is a list of movies you haven't watched yet:"
	echo ""
	ls /Volumes/Data/Shared/movies/__new_movies
	read -p "Which movie do you wish to download?: " ms
}
function oldSeriesList() {
	#TODO
}
function newSeriesList() {
	echo "This is a list of series you haven't watched yet:"
	echo ""
	ls /Volumes/Data/Shared/series/__new_series
	read -p "Which series do you want to download?: " ms
}
function oldMoviesDownload() {
	#TODO
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
function oldSeriesDownload() {
	#TODO
}
function newSeriesDownload() {
	if [ -d ~/Movies/"$ms" ]; then
		echo "Destination directory already exists downloading non-exsiting files..."
		rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/series/__new_series/*"$ms"* ~/Movies/"$ms"
	else
		echo "Creating download directory..."
		mkdir ~/Movies/"$ms"/
		rsync -avz -r --progress /Volumes/Data/Shared/series/__new_series/*"$ms"* ~/Movies/"$ms"
	fi
}
function oldVnewCheck() {
	echo "Old or new entertainment?"
	echo "[o] Old"
	echo "[n] New"
	read -p "Choice: [o/n] " ovn
}
function listAndDownload() {
	if [[ "$category" == "1" ]]; then
		if [[ "$ovn" == "o" ]]; then
			oldMoviesList
			oldMoviesDownload
		elif [[ "$ovn" == "n" ]]; then
			newMoviesList
			newMovieDownload
		fi
	elif [[ "$category" == "2" ]]; then
		oldVnew
		if [[ "$ovn" == "o" ]]; then
			oldSeriesList
			oldSeriesDownload
		elif [[ "$ovn" == "n" ]]; then
			newSeriesList
			newSeriesDownload
		fi
	fi
}
#FUNCTIONS SECTION END
#MAIN SECTION START
if [ -d "/Volumes/Data/Shared" ]; then
	categoryChoice
	oldVnewCheck
	listAndDownload
else
	echo "Volume is not mounted"
fi
#MAIN SECTION END