# pull official base image
FROM python:3.9.6-buster

RUN apt-get update && apt-get install -y \
    redis-server\ 
    nginx

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV FLASK_DEBUG 1
ENV APP_SETTINGS project.server.config.DevelopmentConfig

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

copy ./nginx /etc/nginx

# copy project
COPY . .

RUN chmod a+x run.sh

CMD ["./run.sh"]