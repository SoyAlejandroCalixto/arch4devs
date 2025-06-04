# Read the first 8 fields from the 'cpu' line in /proc/stat
read -r -a stats < /proc/stat

# Calculate total CPU time and idle time (initial measurement)
prev_total=$((stats[1] + stats[2] + stats[3] + stats[4] + stats[5] + stats[6] + stats[7] + stats[8]))
prev_idle=$((stats[4] + stats[5]))  # idle + iowait

# Wait a short interval for second measurement
sleep 0.2

# Perform second reading
read -r -a stats < /proc/stat
total=$((stats[1] + stats[2] + stats[3] + stats[4] + stats[5] + stats[6] + stats[7] + stats[8]))
idle=$((stats[4] + stats[5]))

# Calculate differences
diff_total=$((total - prev_total))
diff_idle=$((idle - prev_idle))

# Calculate usage percentage (avoiding division by zero)
if [[ $diff_total -gt 0 ]]; then
    cpu_usage=$((100 * (diff_total - diff_idle) / diff_total))
else
    cpu_usage=0
fi

echo "$cpu_usage"
