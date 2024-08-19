# # Setting the base image
# FROM python:alpine3.19

# # Setting environment variables
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0

# # Package manager for alpine is apk, that's why we need to select alpine as base image
# RUN apk add --no-cache gcc musl-dev linux-headers

# # Changing working directory to segregate the application
# WORKDIR /app

# # Copying requirements.txt file to install dependencies
# # Why copy requirements.txt first and copy rest of them later?
# # Layer Caching: Docker builds images in layers. When you change a file, only the layers after that file has been copied will need to be rebuilt.
# # If requirements.txt hasn't changed, Docker can reuse the cached layer, speeding up the build process.
# # Efficient Dependency Management: Installing dependencies from requirements.txt is often time-consuming.
# # By copying requirements.txt and running pip install before copying the rest of the code, you ensure that this step is cached and only re-run if requirements.txt changes.
# # Frequent Code Changes: Application code changes more frequently than dependencies.
# # By copying the rest of the code later, you reduce the need to re-install dependencies when you change your application code.
# COPY requirements.txt requirements.txt

# # Install necessary dependencies
# RUN pip install -r requirements.txt

# # Copy rest of the application without .github folder (.dockerignore file has been created)
# COPY . .

# # Expose the application
# EXPOSE 5000

# # Default entrypoint
# ENTRYPOINT ["/bin/sh", "-c"]
# CMD ["flask", "run"]

## Template
# Set the base image
FROM python:alpine3.19
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . .
CMD ["flask", "run"]