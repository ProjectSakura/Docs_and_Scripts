# Copyright (C) 2020 Project Sakura
# Created by LordShenron
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

DATE="$(date +%Y%m%d)"
DAY="$(date +%d/%m/%Y)"

#Starting to get data for ota.
echo "######### OTA GENERATION SCRIPT ##########"
echo "starting script..."
echo "Please enter your device code-name"
read set_codename
echo "Enter the path to sakura folder( example: /home/shen/sakura, just this much yes!)"
read set_ProjectSakura_path
cd "${set_ProjectSakura_path}/out/target/product/${set_codename}"

echo "########## GATHERING DATA #########"
ZIP=$(ls ProjectSakura*.zip)
timestamp=$(cat system/build.prop | grep ro.build.date.utc | cut -d'=' -f2)
name=$(stat -c %n "${ZIP}" | sed 's/.*\///')
filehash=$(md5sum "${ZIP}" | cut -d " " -f 1)
size=$(cat "${ZIP}" | wc -c)
echo "DONE!"

#Putting variables into ota.json.
echo "########## STARTING CREATION OF OTA JSON #########"
echo "{" >> ${set_codename}.json
echo '"response": [' >> ${set_codename}.json
echo "{" >> ${set_codename}.json
echo ' "datetime":' "\"$timestamp \"," >> ${set_codename}.json
echo ' "filename":' "\"$name \"," >> ${set_codename}.json
echo ' "id":' "\"$filehash\"," >> ${set_codename}.json
echo ' "romtype":' "\"nightly\"," >> ${set_codename}.json
echo ' "size":' "$size," >> ${set_codename}.json
echo ' "url":' "\"https://master.dl.sourceforge.net/project/projectsakura/$set_codename/$name\"," >> ${set_codename}.json
echo ' "version":' "\"2.Q\"" >> ${set_codename}.json
echo "}" >> ${set_codename}.json
echo "]" >> ${set_codename}.json
echo "}" >> ${set_codename}.json
echo "DONE!"

#Cloning OTA repo and pushing to it.
echo "####### STARTING PROCESS TO PUSH THE COMMIT #######"
cp -R ${set_codename}.json "${set_ProjectSakura_path}"
echo "Cloning OTA repo now.."
git clone https://github.com/ProjectSakura/OTA
echo "DONE!"
cp -R ${set_codename}.json "${set_ProjectSakura_path}/OTA" && cd "${set_ProjectSakura_path}/OTA"
echo "Creating a commit to push.."
git add . && git commit -s -m "Update: ${set_codename} $DAY"
git push -f origin HEAD:10
cd ../ && rm -rf OTA
echo "Yo!, IT'S DONE!"
