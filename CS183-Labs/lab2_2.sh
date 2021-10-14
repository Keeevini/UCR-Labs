#!/bin/sh

cat /etc/passwd | while read line; do user_name=$(echo $line | awk -F ":" '{print $1}'); user_id=$(echo $line | awk -F ":" '{print $3}'); user_group=$(groups $(echo $line | awk -F ":" '{print $1}') | awk -F ": " '{print $2}'); printf "$user_name $user_id $user_group\n"; done

# Reference use for printf command
# https://linuxize.com/post/bash-printf-command/

# Reference use for bashing
# https://stackoverflow.com/questions/9834086/what-is-a-simple-explanation-for-how-pipes-work-in-bash/9834118

# Reference use for looping a file for each line
# https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash

# Reference used for using awk on a string instead of file
# https://stackoverflow.com/questions/10959133/using-awk-on-a-string




