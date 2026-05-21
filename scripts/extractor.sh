#!/bin/bash
current_file=$1

while true; do
    file_info=$(file "$current_file")
    
    if [[ "$file_info" == *"bzip2 compressed"* ]]; then
        mv "$current_file" temp.bz2
        bzip2 -d temp.bz2
        current_file="temp"
        
    elif [[ "$file_info" == *"gzip compressed"* ]]; then
        mv "$current_file" temp.gz
        gzip -d temp.gz
        current_file="temp"
        
    elif [[ "$file_info" == *"POSIX tar archive"* ]]; then
        mv "$current_file" temp.tar
        next_file=$(tar -tf temp.tar | head -n 1)
        tar -xf temp.tar
        current_file="$next_file"
        
    else
        echo "Extraction complete! The base file is: $current_file"
        echo "Here are the contents:"
        cat "$current_file"
        break
    fi
done