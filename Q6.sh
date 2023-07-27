#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <date>"
    exit 1
fi

filter_date=$(date -d "$1" "+%s")
output_file="filtered_logs.txt"

if [ ! -d "logs" ]; then
    echo "Directory 'logs' not found."
    exit 1
fi

echo "Filtering logs older than $1..."

awk -F ': ' -v filter_date="$filter_date" '
    function get_timestamp(str) {
        gsub(/[-:]/, " ", str);   # Replace '-' and ':' with spaces to make it compatible with mktime
        return mktime(str);
    }
    BEGIN { OFS = FS }
    /^Timestamp:/ {
        timestamp = get_timestamp($2);
        in_range = (timestamp >= filter_date);
    }
    in_range { print }
' logs/log_* | sort -r -k2 > "$output_file"

echo "Filtered logs written to $output_file."
