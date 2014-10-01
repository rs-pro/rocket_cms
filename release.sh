#!/usr/bin/bash
cd mongoid && bundle update && cd .. && cd activerecord && bundle update && cd .. 
gt 'gem update'
cd mongoid && rake release && cd ..
cd activerecord && rake release && cd ..