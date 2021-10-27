#!/bin/bash
echo 'Finding all files in /bin, /sbin, /usr/bin, and usr/sbin that are setuid amd owned by root'
read -p "Hit any key to continue."

find /bin/ -user root -perm -4000
read -p "Hit any key to continue."

find /sbin/ -user root -perm -4000
read -p "Hit any key to continue."

find /usr/bin/ -user root -perm -4000
read -p "Hit any key to continue."

find /usr/sbin/ -user root -perm -4000
read -p "Hit any key to continue."

echo 'Find all files across entire system that have setuid OR setgid permissions'
read -p "Hit any key to continue."
find / -perm /6000
read -p "Hit any key to cintinue."

echo 'find all files in var that have changed in the last 20 minutes'
read -p "Hit any key to continue."
find /var/ -mmin -20
read -p "Hit any key to continue."

echo 'find all files that are regular files in /var that have zero length'
read -p "Hit any key to continue"
find /var/ -type f -empty
read -p "Hit any key to continue."

echo 'find all files in /dev that are not regular files and also not directories. print listing that includes permissions.'
read -p "Hit any key to continue."
find /dev/ -not -type f -not -type d -exec ls -lbd {} \;
read -p "Hit any key to continue."

echo 'find all directories in /home not owned by root, change permissions to ensure they have 711'
read -p "Hit any key to continue."
find /home/ -type d -not -user root -exec chmod 711 {} +
read -p "Hit any key to continue."

echo 'find all regular files in home not owned by root. Change permissions to ensure they have 755'
read -p "Hit any key to continue."
find /home/ -not -user root -exec chmod 755 {} +
read -p "Hit any key to continue."

echo 'find all files of all types in /etc that have changed in the last 5 days'
read -p "Hit any key to continue."
find /etc/ -mtime -5
read -p "Hit any key to continue."
