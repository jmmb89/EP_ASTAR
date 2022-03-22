#!/bin/bash

SCRIPT="main.lua"
ANS=""
BIN="./lua-5.4.4/src/lua"
SENSEI=$(whoami)
CLOSE="\nClosing the Program.. Good bye!"
OS=$(uname -s)

echo -e "\nWelcome $SENSEI starting A* Program on $OS..\n"

if [ "$1" == "bin" ] && ! [ "$OS" == "Linux" ]; then
	./bin/lua $SCRIPT && echo -e $CLOSE && exit
fi

lua -v &> /dev/null

if ! [ "$?" -eq "0" ]; then
	echo -e "\nLua is not installed on your system."
	if ! [ -f "$BIN" ]; then
		echo -e "\nCompile from source? [y,N]"
		read -p '> ' ANS
		if [ "$ANS" == "y" ] || [ "$ANS" == "Y" ]; then
			echo -e "\nDownloading lua..\n"
			curl -R -O http://www.lua.org/ftp/lua-5.4.4.tar.gz
			tar zxf lua-5.4.4.tar.gz
			echo -e "\n\nCompiling Lua..\n"
			cd lua-5.4.4
			make all test
			chmod +x src/lua
			cd ..
			rm lua-5.4.4.tar.gz
		else
			echo -e "\nLua is not installed, aborting\n" && exit
		fi
	else
		echo -e "Using compiled version..\n"
	fi
else
	BIN="lua"
fi

$BIN $SCRIPT

echo -e $CLOSE
