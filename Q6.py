#!/usr/bin/env python3

import os
import sys
from datetime import datetime

def get_timestamp(line):
    timestamp_str = line.split(": ")[1].strip()
    return datetime.strptime(timestamp_str, "%Y-%m-%d").timestamp()

if len(sys.argv) != 2:
    print("Usage: {} <date>".format(sys.argv[0]))
    sys.exit(1)

filter_date_str = sys.argv[1]
try:
    filter_date = datetime.strptime(filter_date_str, "%Y-%m-%d")
except ValueError:
    print("Invalid date format. Please use YYYY-MM-DD.")
    sys.exit(1)

output_file = "filtered_logs.txt"

if not os.path.exists("logs"):
    print("Directory 'logs' not found.")
    sys.exit(1)

print("Filtering logs older than {}...".format(filter_date_str))

filtered_logs = []
for filename in os.listdir("logs"):
    if filename.startswith("log_"):
        with open(os.path.join("logs", filename)) as file:
            timestamp_line = file.readline().strip()
            if not timestamp_line.startswith("Timestamp: "):
                continue
            
            timestamp = get_timestamp(timestamp_line)
            if timestamp >= filter_date.timestamp():
                message = file.readline().strip()
                filtered_logs.append((timestamp_line, "Message: " + message))

filtered_logs.sort(reverse=True, key=lambda x: x[0])

with open(output_file, "w") as output:
    for timestamp_line, message in filtered_logs:
        output.write(timestamp_line + "\n" + message + "\n")

print("Filtered logs written to {}.".format(output_file))
