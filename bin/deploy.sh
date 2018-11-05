# get full path to current script/file
# http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself#comment15185627_4774063
SCRIPT_PATH=$( cd $(dirname $0) ; pwd -P )
SCRIPT_NAME=`basename ${BASH_SOURCE[0]}`


# stop execution if anything fails and exit with non-zero status
set -o errexit # -e
trap "{ echo -e \"\nError: Something went wrong in $SCRIPT_NAME.\">&2; exit 1; }" ERR

# allow DEBUG env variable to trigger simple bash debugging when it is set to
# anything but 'false'
if [ ${DEBUG:=false} != 'false' ] ; then
  set -o verbose # -v
  set -o xtrace  # -x
fi

# allow VERBOSE env variable to control verbosity on individual commands we run.
VERBOSE_ARG=""
DEBUG_ARG=""
if [ ${VERBOSE:=false} != 'false' ] ; then
  VERBOSE_ARG="-v"
  DEBUG_ARG="--debug"
fi

### END: boilerplate bash

# define the codebase root for all scripts. part of standard codeship setup.
#
# FIXME: codeship provides this via their 'cs p' command. the dir could in
# theory change, so it should not really be hardcoded.
export PROJECT_ROOT="$HOME/clone"

cd $PROJECT_ROOT
ls -lsat

if [ ! -d "greaterdc-data-explorer" ]; then
  echo "/greaterdc-data-explorer directory does not exist."
  git clone git@github.com:UI-Research/greaterdc-data-explorer.git
  git checkout stg
else
  echo "/greaterdc-data-explorer directory exists ."
  git checkout stg
  git pull origin master
fi
ls -lsat

# rename repo to correct name
if [ ! -d "greaterdc-data-explorer/data" ]; then
  mkdir greaterdc-data-explorer/data

  mv -v $PROJECT_ROOT/safety $PROJECT_ROOT/greaterdc-data-explorer/data/safety
  mv -v $PROJECT_ROOT/population $PROJECT_ROOT/greaterdc-data-explorer/data/population
  mv -v $PROJECT_ROOT/income $PROJECT_ROOT/greaterdc-data-explorer/data/income
  mv -v $PROJECT_ROOT/housing $PROJECT_ROOT/greaterdc-data-explorer/data/housing
  mv -v $PROJECT_ROOT/health $PROJECT_ROOT/greaterdc-data-explorer/data/health
  mv -v $PROJECT_ROOT/help-text.csv $PROJECT_ROOT/greaterdc-data-explorer/data/help-text.csv
  mv -v $PROJECT_ROOT/employment $PROJECT_ROOT/greaterdc-data-explorer/data/employment
  mv -v $PROJECT_ROOT/education $PROJECT_ROOT/greaterdc-data-explorer/data/education
  mv -v $PROJECT_ROOT/connection $PROJECT_ROOT/greaterdc-data-explorer/data/connection
else
  rm -rf greaterdc-data-explorer/data
  mkdir greaterdc-data-explorer/data

  mv -v $PROJECT_ROOT/safety $PROJECT_ROOT/greaterdc-data-explorer/data/safety
  mv -v $PROJECT_ROOT/population $PROJECT_ROOT/greaterdc-data-explorer/data/population
  mv -v $PROJECT_ROOT/income $PROJECT_ROOT/greaterdc-data-explorer/data/income
  mv -v $PROJECT_ROOT/housing $PROJECT_ROOT/greaterdc-data-explorer/data/housing
  mv -v $PROJECT_ROOT/health $PROJECT_ROOT/greaterdc-data-explorer/data/health
  mv -v $PROJECT_ROOT/help-text.csv $PROJECT_ROOT/greaterdc-data-explorer/data/help-text.csv
  mv -v $PROJECT_ROOT/employment $PROJECT_ROOT/greaterdc-data-explorer/data/employment
  mv -v $PROJECT_ROOT/education $PROJECT_ROOT/greaterdc-data-explorer/data/education
  mv -v $PROJECT_ROOT/connection $PROJECT_ROOT/greaterdc-data-explorer/data/connection
fi

echo "==========================================================="
cd greaterdc-data-explorer
ls -lsat data
echo "==========================================================="
ls -lsat
echo "==========================================================="
pwd
echo "==========================================================="

yarn build-skip-verify
