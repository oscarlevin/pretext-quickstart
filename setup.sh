#!/bin/bash

# This script will set up an authors PreTeXt project

# Global variables:
ptxgithub="https://github.com/rbeezer/mathbook.git"

optionMenu () {
  echo
  echo -e "What would you like to do?\n\n 1. Install PreTeXt. \n 2. Generate .ptx files (set up directories). \n 3. Configure build script. \n 4. Exit. \n"
  read -p "Enter your choice: " menuChoice
  case $menuChoice in
    1|1.|[iI]*)
      echo "You want to install PreTeXt"; optionMenu;;
    2*|[gG]*)
      echo "You want to generated PTX files"; optionMenu;;
    3*|[cCbB]*)
      echo "You want to configure the build script."; optionMenu;;
    4*|[eEqQ]*)
      echo "Exiting..."; exit;;
  esac
}

checkPreTeXt () {
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
}

installPTX () {
  echo "Enter the path in which to install PreTeXt"
  read installpath
  installpath="${installpath}/mathbook"
  install -d $installpath
  git clone $ptxgithub $installpath
  echo "Downloaded PreTeXt to $installpath"
  ptxPath=$installpath
}

copyTemplate () {
  install -d $projectPath
  cp -R ptx $projectPath
  cp -R xsl $projectPath
  install -d $projectPath/latex
  install -d $projectPath/html
  install -d $projectPath/images
  cp .gitignore $projectPath
  cp Makefile $projectPath
  cp Makefile.paths.original $projectPath
  echo -e "\n\nCopied project template to $projectPath\n\n"
}

subInfo () {
  sed -i "s/{title}/$title/g" $projectPath/ptx/*
  sed -i "s/{subtitle}/$subtitle/g" $projectPath/ptx/*
  sed -i "s/{author}/$author/g" $projectPath/ptx/*
}


optionMenu


# 
# 
# 
# # # Set folder name and copy template there:
# # read -p "Enter a name for the folder that will hold your project: " folderName
# # projectPath="$(dirname "$PWD")"/${folderName}
# # copyTemplate
# # 
# # 
# # ## Set up all the variables for the project:
# # read -p "What is the title of the book? " title
# # read -p "What is the subtitle of the book? (leave blank if none) " subtitle
# # read -p "What is the name of the author of the book? " author
# # 
# # subInfo
