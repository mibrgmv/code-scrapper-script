#!/bin/bash

project_dir=$(pwd)
output_file="${project_dir}/code_context.txt"

if [ -f "$output_file" ]; then
  rm "$output_file"
fi

# list your desired directories
directories=()
ignore_files=("*.ico" "*.png" "*.jpg" "*.jpeg" "*.gif" "*.svg")

read_files() {
for entry in "$1"/*
do
if [ -d "$entry" ]; then
      read_files "$entry"
elif [ -f "$entry" ]; then
      should_ignore=false
for ignore_pattern in "${ignore_files[@]}"; do
if [[ "$entry" == "$ignore_pattern" ]]; then
          should_ignore=true
break
fi
done

if ! $should_ignore; then
        relative_path=${entry#"$project_dir/"}
        echo "// File: $relative_path" >> "$output_file"
        cat "$entry" >> "$output_file"
        echo "" >> "$output_file"
fi
fi
done
}

for dir in "${directories[@]}"; do
  if [ -d "${project_dir}/${dir}" ]; then
    read_files "${project_dir}/${dir}"
  fi
done