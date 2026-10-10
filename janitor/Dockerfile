ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.11
FROM $BUILD_FROM

# Install system dependencies if required
RUN apk add --no-cache git

# Copy requirements or application code
WORKDIR /app
RUN git clone https://github.com/a-bali/janitor.git /app

# Install python dependencies if a setup.py or requirements.txt exists
RUN if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

# Copy run script
COPY run.sh /
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
