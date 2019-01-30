#!/bin/bash

[ -f size_report.txt ] && rm size_report.txt

while IFS=";" read -r p || [ -n "$p" ]
do
  FILE=$(echo $p | cut -d ";" -f 1)
  SIZE=$(du -h $FILE)
  echo $SIZE >> size_report.txt
done < .size_tracker
