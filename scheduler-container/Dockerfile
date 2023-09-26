FROM python:3.9.18-bullseye

ARG SCHEDULER_VERSION="0.0.1"

#DONT PRODUCE .PYC FILES
ENV PYTHONDONTWRITEBYTECODE=1

#TURN OFF BUFFERING FOR LOGIN
ENV PYTHONUNBUFFERED=1

#INSTALL REQUIREMENTS
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
COPY . /app

#CREATE NON ROOT USER AND ADD PERMISSION TO ACCESS APP DIRECTORY
RUN useradd scheduler && chown -R scheduler /app
USER scheduler
RUN chmod +x ./pod_scheduler.py

#RUN SCHEDULER
WORKDIR /app/
ENTRYPOINT ["./pod_scheduler.py"]
