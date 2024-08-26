FROM postgres:latest

ENV POSTGRES_USER postgresUser
ENV POSTGRES_PASSWORD postgresPW
ENV POSTGRES_DB postgresDB

LABEL Description="This is a base image, which provides the Postgres with Python-Pytest setup for test"

#Install the Python dependencies
RUN apt-get update \
  && apt-get install -y python3 python3-pip \
  && rm -rf /var/lib/apt/lists/*

# Install all the test requirements
COPY requirements.txt .
RUN python -m pip install --upgrade pip \
  && pip install -r requirements.txt --break-system-packages \
  && rm -f requirements.txt

# Set PYTHONPATH
ENV PYTHONPATH=/usr/bin/python3/usr/bin/:/usr/lib/python3/dist-packages/:/home/jenkins/work:

VOLUME /home
WORKDIR /home

EXPOSE 5557 5558 8089 5432

# # Copy the current directory to /home directory of docker container
# COPY dummy_project_1/. /home/
# RUN cd /home
# RUN su postgres -c pytest test_app.py