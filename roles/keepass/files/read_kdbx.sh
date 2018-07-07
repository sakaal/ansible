#!/bin/bash
#
# INSECURE - THIS SCRIPT IS FOR TESTING PURPOSES ONLY.
# DO NOT USE IN PRODUCTION.
#
config_file=~/.keepass/credentials

if [ -f "$config_file" ]; then
    . "$config_file"
else
    echo "Missing ${config_file}" 1>&2
    exit 1
fi

echo "Reading entry '$keepass_entry' from file '$keepass_db'..."

function read_entry {
    expect <<- EOF
	set timeout 5
	spawn kpcli
	match_max 4096
	expect "kpcli:/>"
	send   "open '$(printf %q "$keepass_db")' '$(printf %q "$keepass_keyfile")'\n"
	expect "password:"
	send   "$keepass_password\n"
	expect ">"
	send   "cd '$(printf %q "$keepass_dir")'\n"
	expect ">"
	send   "show -f '$(printf %q "$keepass_entry")'\n"
	expect ">"
	send   "quit\n"
	expect eof
	EOF
}

relevant_lines=$(echo "$(read_entry)" | grep "^\s*\(Title\|Pass\|Notes\):")

function trim() {
    local var="$*"
    # remove leading whitespace
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}

while IFS=": " read -r key value; do
   case "$key" in
       Title) title=$(trim "$value") ;;
       Pass)  passw=$(trim "$value") ;;
       Notes) notes=$(trim "$value") ;;
   esac
done <<< "$relevant_lines"

echo "title='$title' passw='$passw' notes='$notes')"
