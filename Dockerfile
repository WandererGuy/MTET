# Use an official Ubuntu image as a base
FROM nvidia/cuda:12.8.0-base-ubuntu22.04
# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install Python, pip, git, and other dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip git && \
    rm -rf /var/lib/apt/lists/*

# Optionally, set up a symlink for python if needed
RUN ln -s /usr/bin/python3 /usr/bin/python

# Set the working directory in the container
WORKDIR /app

# Copy your requirements file and install Python packages
COPY requirements.txt .
RUN pip3 install --upgrade pip && \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 && \
    pip install transformers && \
    pip install fastapi uvicorn pydantic python-multipart

# Copy your project code into the container
COPY . .

# If your project requires code from GitHub and it's not part of your local copy,
# you can clone it here. (Be cautious with sensitive info.)
# RUN git clone https://github.com/yourusername/your-github-repo.git /app/github_code

# Use volumes for local checkpoints or data to avoid copying them into the image.
# For example, if you have a checkpoints directory:
# docker run -v /local/path/to/checkpoints:/app/checkpoints your_project_image

# Specify the command to run your application
CMD ["python", "main.py"]
