import subprocess, os

directory = "/Volumes/Data/Shared"
choice = ""
category = ""
oldOrNew = ""
title = ""

def categoryChoice():
    print("Which category do you want to download?")
    print("[1] movies")
    print("[2] series")
    print("[3] anime")
    category = input("Category choice: [1-3] ")
    return category

def oldvnew():
    oldOrNew = input("Old or new entertainment? [o/n] ")
    return oldOrNew

def listfiles():
    if oldOrNew == "o":
        print("This is a list of " + category + " that is available:")
        subprocess.run(["ls", directory + "/" + category])
        title = input("Which movie do you wish to download?: ")
        return title
    if oldOrNew == "n":
        print("This is a list of new " + category + " that is available:")
        subprocess.run(["ls", directory + "/" + category + "/__new_" + category])
        title = input("Which new movie do you wish to download?: ")
        return title


def download():
    if oldOrNew == "o":
        subprocess.run(["rsync", "-avz", "-r", "--ignore-existing", "--progress", "/Volumes/Data/Shared/" + category + "/*" + title + "*", "/Users/grey/Movies/" + title])
    if oldOrNew == "n":
        subprocess.run(["rsync", "-avz", "-r", "--ignore-existing", "--progress", "/Volumes/Data/Shared/" + category + "/__new_" + category + "/*" + title + "*", "/Users/grey/Movies/" + title])

if os.path.exists(directory):
    choice = categoryChoice()
    if choice == "1":
        category = "movies"
        oldOrNew = oldvnew()
        title = listfiles()
        download()
    if choice == "2":
        category = "series"
        oldOrNew = oldvnew()
        title = listfiles()
        download()
    if choice == "3":
        category = "anime"
        oldOrNew = oldvnew()
        title = listfiles()
        download()  
else:
    print("Volume is not mounted")