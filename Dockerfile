# Step 1: Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Step 2: Set the working directory in the container
WORKDIR /app
# COPY . /app

# Step 3: Install any required dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    git \
    # Add any additional dependencies your application requires
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/WandererGuy/MTET.git
WORKDIR /app/MTET
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
RUN pip install transformers
RUN pip install fastapi uvicorn pydantic python-multipart
RUN ln -s /usr/bin/python3 /usr/bin/python
# port in config/config.ini
EXPOSE 4013

CMD ["python", "main.py"]

# docker build --no-cache -t mtet .    
# docker run -it --gpus all -p 4013:4013 mtet
