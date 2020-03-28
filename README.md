# Euphemia

Euphemia is a Python app with website support using Flask, HTML, CSS and ReactJS running in Docker container

## Setup
```
# create project folder
mkdir ~/webdev/python/euphemia
cd ~/webdev/python/euphemia
mkdir euphemia-solver
cd euphemia-solver
mkdir static tasks models config
```

## Docker Container Configuration
```
# copy Python Dockerfile from aloneword project
cp ~/webdev/python/aloneword/Dockerfile .

# build the docker container
# for development
docker build --rm -t "euphemia:dev" . --build-arg BUILD_ENV=development

# for production (ignore if not in devops)
docker build --rm -t "euphemia:pro" . --build-arg BUILD_ENV=production

# test run docker container
# for development
docker run -it -v ~/webdev/python/euphemia:/opt/euphemia euphemia:dev

# for production (ignore if not in devops)
docker run -it euphemia:pro
```

## Install dependencies (only for devops)
This will install python dependencies inside the container and generate requirements.txt
Done only once or when new dependencies added.
When creating container, it pip install -r /tmp/requirements.txt
```
pip install flask flask-restful flask-sqlalchemy flask-migrate celery
pip freeze > requirements.txt
```

## Main app functions
Put core functions of the app inside euphemia-solver

## Web app function
Modules and functions to run the web application inside euphemia-web

## Usage
### Web
After you run and login into the docker container, run the below commands, and point your browser to 127.0.0.1
(run in development and local mode, docker run -it -v ~/webdev/python/euphemia:/opt/euphemia euphemia:dev)
```
export FLASK_APP=euphemiaweb
export FLASK_ENV=development
pip install -e .
flask run --host=0.0.0.0
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
