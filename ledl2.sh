#!/bin/bash
#LEDL - Local Entertainment Downloader v2
#Code can be used freely as long as I am credited
#Rewrite of ledl.sh to optimize linecount and readeability
function list {
    case "$type" in
    o)
        echo "This is a list of" "$category" "that is available:"
        echo ""
        ls /Volumes/Data/Shared/"$category"
        read -p "Which ""$category"" do you wish to download?: " title ;;
    n)
        echo "This is a list of" "$category" "that is available:"
        echo ""
        ls /Volumes/Data/Shared/__new_"$category"
        read -p "Which ""$category"" do you wish to download?: " title ;;
    q) echo "Bye!" ;; 
    esac
}
function download {
    if [ "$type" == "o" ]; then
        if [ -d ~/"$category"/"$title" ]; then
            echo "Destination directory already exists downloading non-exsiting files..."
            rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/"$category"/*"$title"* ~/Movies/"$title"
        else
            echo "Creating download directory..."
            mkdir ~/"$category"/"$title"/
            rsync -avz -r --progress /Volumes/Data/Shared/"$category"/"$category"/*"$title"* ~/Movies/"$title"
        fi
    elif [ "$type" == "n" ]; then
        if [ -d ~/"$category"/"$title" ]; then
            echo "Destination directory already exists downloading non-exsiting files..."
            rsync -avz -r --ignore-existing --progress /Volumes/Data/Shared/__new_"$category"/*"$title"* ~/Movies/"$title"
        else
            echo "Creating download directory..."
            mkdir ~/"$category"/"$title"/
            rsync -avz -r --progress /Volumes/Data/Shared/"$category"/__new_"$category"/*$title* ~/Movies/"$title"
        fi
    else return 0
    fi
}
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
    echo "Do you wish to look at old or new entertainment?"
    echo "[o] old"
    echo "[n] new"
    read -p "Type choiche: [o/n]" type
}
#MAIN SECTION START
if [ -d "/Volumes/Data/Shared" ]; then
    categoryChoice
    oldvnew
    list
    download
else
    echo "Volume is not mounted"
fi