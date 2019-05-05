#!/usr/bin/env bash

no_angular_app_warning () {
  echo
  png-utils chalk '***************************************************************' yellow
  png-utils chalk 'This command should be run from within angular application root' yellow
  png-utils chalk '***************************************************************' yellow
  echo
}

commands="new generate g theme add"
if [[ $commands =~ (^|[[:space:]])$1($|[[:space:]]) ]] && [ $2 ] || [ $1 = "theme" ] ; then
  ARGS="$*"

  if  [ "$1" = "new" ] ; then
    if  [ "$2" = "help" ] || [ "$2" = "--help" ] || [ "$2" = "-h" ] ; then
      png-utils help new
    else
      # primeng-schematics/node_modules/.bin/ng $ARGS -c primeng-schematics --minimal true
      npx @angular/cli@7 $ARGS -c primeng-schematics
      echo
      png-utils figlet 'ng serve' 
      echo
      # cd to the newly created app
      cd $2
      `npm bin`/ng serve -o
    fi
  elif [ "$1" = "g" ] || [ "$1" = "generate" ] ; then
    if  [ "$2" = "help" ] || [ "$2" = "--help" ] || [ "$2" = "-h" ] ; then
      png-utils help g
    elif [ ! -f package.json ] || [ ! -f angular.json ] ; then
      no_angular_app_warning
    else
      #firstitem=$1
      #shift;
      #ARGS="$*"
      ECHO $ARGS
      `npm bin`/ng $ARGS
    fi
  elif [ "$1" = "theme" ] ; then
    if  [ "$2" = "help" ] || [ "$2" = "--help" ] || [ "$2" = "-h" ] ; then
      png-utils help theme
    elif [ ! -f package.json ] || [ ! -f angular.json ] ; then
      no_angular_app_warning
    elif [ $2 ] ; then
      `npm bin`/ng add primeng-schematics --changeThemeOnly $ARGS
    fi
  elif [ "$1" = "add" ] ; then
    if [ "$2" = "help" ] || [ "$2" = "--help" ] || [ "$2" = "-h" ] ; then
      png-utils help add
    elif [ ! -f package.json ] || [ ! -f angular.json ] ; then
      no_angular_app_warning
    else
      `npm bin`/ng add primeng-schematics $ARGS
    fi
  elif [ "$1" = "help" ] ; then
    png-utils help
  fi 
else
  png-utils help
fi  