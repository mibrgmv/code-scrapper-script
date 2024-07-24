## Purpose 
The script collects all code from given directories and merges it into a neat .txt file to help you with counting lines or submitting the code to an AI model.
## Instruction
1. Insert the `script.sh` file into the root directory of your project.
2. Type in subdirectory names into the `directories` folder inside the file. **Note**: they must be in the same parent directory, as the `script.sh` file.
3. Run the script via terminal: `bash script.sh`.
4. Your code now should appear in the same directory as `code_context.txt`.
## Code 
```shell
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
```
