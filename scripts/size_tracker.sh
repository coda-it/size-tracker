#!/bin/bash

NEWER_TAG=$(git tag --sort version:refname | tail -r | sed -n 1p)
OLDER_TAG=$(git tag --sort version:refname | tail -r | sed -n 2p)
HEADER="# Sizelog from $NEWER_TAG"
DIR=./docs/sizelogs

if [ ! -d $DIR ]
    then
    mkdir -p $DIR
fi

SIZEFILE=$DIR/SIZELOG_$NEWER_TAG.md

[ -f size_report.txt ] && rm size_report.txt

echo $HEADER > $SIZEFILE
echo "### Sizefiles" >> $SIZEFILE

while IFS=";" read -r p || [ -n "$p" ]
do
  FILE=$(echo $p | cut -d ";" -f 1)
  SIZE=$(du -h $FILE)
  echo "* $SIZE" >> $SIZEFILE
done < .size_tracker
