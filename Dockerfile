FROM python:3.11-slim

WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Python libraries sab install karo
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    requests \
    plotly \
    ipywidgets \
    jupyterlab-git \
    nbformat \
    psutil \
    jupyterlab-system-monitor

# Persistent storage folder
RUN mkdir -p /data/notebooks

ENV PORT=8080
ENV JUPYTER_TOKEN=nur1234
ENV JUPYTER_DIR=/data/notebooks

EXPOSE 8080

CMD jupyter lab \
  --ip=0.0.0.0 \
  --port=${PORT} \
  --no-browser \
  --allow-root \
  --ServerApp.token=${JUPYTER_TOKEN} \
  --ServerApp.password='' \
  --ServerApp.root_dir=${JUPYTER_DIR} \
  --ServerApp.autosave_interval=30 \
  --ServerApp.shutdown_no_activity_timeout=0
