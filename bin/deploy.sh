
if [ ! -d "greaterdc-data-explorer" ]; then
  echo "/greaterdc-data-explorer directory does not exist."
  git clone git@github.com:UI-Research/greaterdc-data-explorer.git
  git checkout master
  cd greaterdc-data-explorer
else
  echo "/greaterdc-data-explorer directory exists ."
  cd greaterdc-data-explorer
  git checkout master
  git pull origin master
fi

cd greaterdc-data-explorer

if [ ! -d "greaterdc-map-data" ]; then
  echo "/greaterdc-map-data directory does not exist."
  git clone git@github.com:UI-Research/greaterdc-map-data.git
  git checkout stg
else
  echo "/greaterdc-data-explorer directory exists ."
  git checkout stg
  git pull origin stg
fi

# rename repo to correct name
if [ ! -d "data" ]; then
  mv greaterdc-map-data data
else
  rm -rf data
  mv greaterdc-map-data data
fi

# cd ../
 nvm install 8.6
 yarn build-skip-verify
