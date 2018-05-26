#!/bin/bash
git pull --rebase
bundle update
git add --all .
git commit -am "${*:1}"
git push
rake release
sleep 3
cd mongoid
bundle update && rake release
cd ..
cd activerecord
bundle update && rake release
cd ..
cd mongoid_light
bundle update && rake release
cd ..
cd activerecord_light
bundle update && rake release
cd ..
