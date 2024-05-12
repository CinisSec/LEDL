#!/bin/bash
#LEDL - Local Entertainment Downloader v2
#Code can be used freely as long as I am credited
#Rewrite of ledl.sh to optimize linecount and readeability
function categoryChoice {
    echo "Which category do you want to download?"
    echo "[1] movies"
    echo "[2] series"
    echo "[3] anime"
    read -p "Category choice: [1-3]" category
    case $category in
    1) category="movies" ;;
    2) category="series" ;;
    3) category="anime" ;;
    esac
}
function oldvnew {
    read -n1 -p "Old or new entertainment? [o/n] " type
}
function list {
    echo "This is a list of" "$category" "that is available:"
    echo ""
    case "$type" in
    o) ls /Volumes/Data/Shared/"$category" ;;
    n) ls /Volumes/Data/Shared/"$category"/__new_"$category" ;;
    q) echo "Bye!" ;;
    *) echo "Invalid choice" && list ;;
    esac
    read -p "Which $category do you wish to download?: " title
}
function download {
    if [ "$type" == "o" ]; then
        rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/"$category"/*$title* ~/Movies/"$title"
    elif [ "$type" == "n" ]; then
        rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/"$category"/__new_"$category"/*$title* ~/Movies/"$title"
    else return 0
    fi
}
#MAIN SECTION START
#Check if volume is mounted and run functions else print error
if [ -d "/Volumes/Data/Shared" ]; then
    categoryChoice
    oldvnew
    list
    download
else
    echo "Volume is not mounted"
fi