# Copyright (C) 2020 Project Sakura
# Author: LordShenron
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
DAY="$(date +%d/%m/%Y)"
#Starting to get data for ota.
echo "######### CHANGELOG GENERATION ##########"
echo "It generates the commit history only from Frameworks."
echo "starting script..."
echo "Enter the path to sakura folder( example: /home/shen/sakura, just this much yes!)"
read set_ProjectSakura_path
cd "${set_ProjectSakura_path}/frameworks/base/"
echo "######      Changelog for $DAY       ######" >> changelog.txt
echo "## These are changes made to the framework only ##" >> changelog.txt
echo "##   For more changes check the repositories    ##" >> changelog.txt
echo "" >> changelog.txt
git log --pretty=format:"%s" --since=4.weeks >> changelog.txt
cp -R changelog.txt "${set_ProjectSakura_path}" && cd -
exit 0;
