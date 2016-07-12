#!/bin/bash

#############################################################
# Simple script to add copyright header to the source files
############################################################

COPYRIGHT="// Copyright 2016 Fraunhofer Institute for Applied Information Technology FIT"

echo $COPYRIGHT > copyright-header
echo "" >> copyright-header

# go code
for i in `find src/ -iname "*.go"`
do
  if ! grep -q Copyright ${i}
  then
	echo "Adding header to ${i}..."
    	cat copyright-header ${i} > ${i}.new && mv ${i}.new ${i}
  fi
done

rm copyright-header
