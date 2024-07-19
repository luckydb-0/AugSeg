# Base image with Python and other common tools
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
	
RUN pip install gdown==3.3.1

# Copy the script and other necessary files into the container
COPY . /workspace

# Set the working directory here just to download the checkpoint
WORKDIR /workspace/checkpoints

RUN gdown 1-9c7alBRxAiipj5Tj9_RzIklC6at4k_U

WORKDIR /workspace

# Install Python dependencies (if there are any listed in requirements.txt)
# COPY requirements.txt /workspace/
RUN pip install --no-cache-dir -r requirements.txt

RUN wget -O /workspace/dataset.tar "http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar" \
    && tar -xvf /workspace/dataset.tar -C /workspace \
    && rm /workspace/dataset.tar

RUN mv /workspace/VOCdevkit/VOC2012/ /workspace/data/

# Ensure the script is executable
RUN chmod +x /workspace/scripts/zsing_run_voc_gpu.sh

# Run the script
CMD ["/bin/bash", "/workspace/scripts/zsing_run_voc_gpu.sh"]
