#!/usr/bin/env bash

PASSWORD_LENGTH=8
INCLUDE_LOWER=true
INCLUDE_UPPER=true
INCLUDE_NUMBERS=true
INCLUDE_SPECIAL=false


generate_password() {
    local length=$1
    local include_lower=$2
    local include_upper=$3
    local include_numbers=$4
    local include_special=$5

    local charset=""
    [ "$include_lower" == "true" ] && charset+="abcdefghijklmnopqrstuvwxyz"
    [ "$include_upper" == "true" ] && charset+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    [ "$include_numbers" == "true" ] && charset+="0123456789"
    [ "$include_special" == "true" ] && charset+="!@#$%^&*()-_=+[]{}|;:,.<>?/~"

    local password=""
    for (( i=0; i<$length; i++ )); do
        password+="${charset:RANDOM%${#charset}:1}"
    done
    echo "$password"
}



if [ $# -lt 1 ]; then
    echo "Usage: 7 [-p] /path/to/file_or_directory"
	echo "[-p] Password-encrypts the zipped file automatically and echo's the password."
    exit 1
fi

USE_PASSWORD=false
if [ "$1" == "-p" ]; then
    USE_PASSWORD=true
    shift
fi

input_path="$1"
output_file="${input_path%/}.7z"

if [ "$USE_PASSWORD" == "true" ]; then
    password=$(generate_password $PASSWORD_LENGTH $INCLUDE_LOWER $INCLUDE_UPPER $INCLUDE_NUMBERS $INCLUDE_SPECIAL)
    echo "Generated password: $password"
    7z a -p"$password" -mhe=on "$output_file" "$input_path"
else
    7z a -p -mhe=on "$output_file" "$input_path"
fi
