# Use a stable, slim Python base image
ARG BASE_IMAGE=python
ARG BASE_IMAGE_TAG=3.12-slim

FROM ${BASE_IMAGE}:${BASE_IMAGE_TAG}

ARG \
    MLFLOW_VERSION=3.2.0 \
    MLFLOW_USER="mobyware" \
    MLFLOW_UID="1331" \
    MLFLOW_GROUP="mobyware" \
    MLFLOW_GID="1331" \
    MLFLOW_ROOT="/mlflow_server"

ENV ML_ROOT=${MLFLOW_ROOT}

# Install MLflow. You can add other dependencies like boto3 for S3
# or psycopg2 for PostgreSQL if you were connecting to external services.
RUN pip install mlflow==${MLFLOW_VERSION} boto3 --no-cache
# Create directories for the backend store (metadata) and the default artifact root.
# This ensures they exist when the server starts.
RUN \
    mkdir -p ${MLFLOW_ROOT}/data && mkdir -p ${MLFLOW_ROOT}/artifacts \
    && addgroup --gid ${MLFLOW_GID} --system ${MLFLOW_GROUP} \
    && adduser --uid ${MLFLOW_UID} --system ${MLFLOW_USER} --gid ${MLFLOW_GID} \
    && chown -R ${MLFLOW_USER}:${MLFLOW_GROUP} ${MLFLOW_ROOT} 

# Set a working directory inside the container
WORKDIR ${MLFLOW_ROOT}

# Expose the default MLflow port
EXPOSE 5000

USER ${MLFLOW_UID}