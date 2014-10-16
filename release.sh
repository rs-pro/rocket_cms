#!/usr/bin/bash
bundle update
gt "${*:1}"
rake release
cd mongoid && bundle update && cd ..
cd activerecord && bundle update && cd .. 
gt 'release gem'
cd mongoid && rake release && cd ..
cd activerecord && rake release && cd ..