#!/bin/bash
set -euo pipefail

# get the arguments from the command line
bucket="$1"
book_dir="$2"

# create the book directory if it doesn't yet exist
mkdir -p "$book_dir"

#copy every txt file from the bucket
aws s3 cp "s3://$bucket" "$book_dir" --recursive --exclude "*" --include "*.txt"

#make the directory absolute, then get each book with its full absolute path
book_dir="$(realpath "$2")"
find "$book_dir" -name "*.txt"

#write new book list file, pipe final list and sort it
echo "File path" > book_list.txt
find "$book_dir" -name "*.txt" | sort >> book_list.txt

#print how many books (dont count header)
count=$(tail -n +2 book_list.txt | wc -l)
echo "There are $count books in book_list.txt"
