#!/bin/bash

# This script will set up an authors PreTeXt project

# Global variables:
ptxgithub="https://github.com/rbeezer/mathbook.git"

installPTX () {
  echo "Enter the path in which to install PreTeXt"
  read installpath
  installpath="${installpath}/mathbook"
  install -d $installpath
  git clone $ptxgithub $installpath
  echo "Downloaded PreTeXt to $installpath"
  ptxPath=$installpath
}

#Find directories 'mathbook'
ptxPaths=$(find ~/ -name "mathbook" -type d)
# readarray -td, array <<< "$ptxPath"; declare -p array;
ptxPathArray=($ptxPaths)

#If no 'mathbook' directory found, ask to install.  If multiple, ask for which.  Otherwise give the only option.
#perhaps should give option to specify custom path?
if [ ${#ptxPathArray[@]} -eq 0 ]
then
  echo -e "No folder 'mathbook' found on your system.\n"
  read -p "Would you like to install it (y/n)? " yn
  case $yn in
    [Yy]* ) installPTX;;
    [Nn]* ) echo "Please install manually and rerun setup.sh"; exit;;
    * ) echo "Please enter 'yes' or 'no'.";;
  esac
elif [ ${#ptxPathArray[@]} -gt 1 ]
then
  echo -e "Multiple 'mathbook' folders found.\n" 
  for index in "${!ptxPathArray[@]}"
  do
    echo "$index. ${ptxPathArray[index]}"
  done
  echo ""
  read -p "Which of these is the mathbook you would like to use? (enter number) " idx
  ptxPath=${ptxPathArray[$idx]}
else
  ptxPath=${ptxPathArray[0]}
fi
echo -e "\nPreTeXt directory set to $ptxPath\n"
# if 
# installPTX
