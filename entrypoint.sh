#!/bin/bash

set -ue

current_file=$INPUT_FILES
report_extension=".txt"
report_name=$INPUT_REPORT_NAME$report_extension

touch "$report_name"
echo '' > "$report_name"

is_yml_or_yaml_file(){
  file_to_check=$1
  if [[ $file_to_check =~ \.yml$ ]]  || [[ $file_to_check =~ \.yaml$ ]];then
    return 0
  else
    return 1
  fi
}

get_current_dir_if_files_are_empty(){
  if [ -z "$current_file" ];then
    echo "Getting default value for files $current_file."
    current_file=$(pwd)
  fi
}

main(){
  inside_file=$1
  IFS=',' read -ra provided_files <<< "$inside_file"
  for file in "${provided_files[@]}";do
     if [ -d "$file" ]; then
       for r_file in "$file"/*;do
         main "$r_file"
       done
     else
       if (is_yml_or_yaml_file "$file" ); then
         kubeval "$file" |  cat >> "$report_name"
         echo -e "\n"  >> "$report_name"
       else
         echo "File $file has not .yml or .yaml extension."
       fi
     fi
  done
}

get_current_dir_if_files_are_empty
main "$current_file"
echo "::set-output name=report::$report_name"
printf "\n✅ Successfully validated files.\n"
