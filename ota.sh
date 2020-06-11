#!/bin/bash

echo "######### THIS SCRIPT WILL SHOW YOU INFORMATION NEEDED FOR OTA JSONS ##########"
echo "starting script..."
echo "Please enter the path where Sakura folder is located (full path ex:/home/<user>/<folder-name>)"
read set_ProjectSakura_path
cd "${set_ProjectSakura_path}"
ZIP=$(ls ProjectSakura*.zip)
timestamp=$(cat system/build.prop | grep ro.build.date | cut -d'=' -f2)
name=$(stat -c %n "${ZIP}" | sed 's/.*\///')
filehash=$(md5sum "${ZIP}" | cut -d " " -f 1)
size=$(cat "${ZIP}" | wc -c)
msg=$(mktemp)
   {
      echo -e "Project Sakura build ${status}"
      echo -e "Datetime: ${timestamp}"
      echo -e "Filename: ${name}"
      echo -e "ID: ${filehash}"
      echo -e "romtype": "nightly",
      echo -e "Size ${size}"
      echo -e "url: paste the url here"
      echo -e "version": "1.Q"
   } > "${msg}"

BJSON=$(cat "${msg}")
cat "${msg}"
