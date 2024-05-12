# Use the official ubuntu 18.04 LTS as base image
FROM ubuntu:18.04

# Update and install dependencies
RUN apt-get update -y && \
    apt-get install -y python3.6 python3-pip

# Set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app/

# Install any needed packages specified in requirements.txt
RUN pip3 install -r /app/requirements.txt

# Make migrations for DB
RUN python3.6 /app/manage.py makemigrations

# Apply the migrations
RUN python3.6 /app/manage.py migrate

# Expose port 8000 to the outside world
EXPOSE 8000

# Command to run when the container is started
CMD ["python3.6", "/app/manage.py", "runserver", "0.0.0.0:8000"]