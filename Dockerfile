# Setting the base image
FROM python:3.13.0b4-alpine3.20

# Setting environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers

# Changing working directory to segregate the application
WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

# Default entrypoint
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["flask", "run"]