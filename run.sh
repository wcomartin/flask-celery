#!/bin/bash

exec service redis-server start &
exec python manage.py run -h 0.0.0.0 &
exec celery worker --app=project.server.tasks.celery --loglevel=info --logfile=project/logs/celery.log &
exec flower --app=project.server.tasks.celery --port=5555 --broker=redis://localhost:6379/0