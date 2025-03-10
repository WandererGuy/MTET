# prepare
```
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
pip install transformers
pip install fastapi uvicorn pydantic python-multipart
```


# docker 
docker build -t mtet_image .
docker run -it mtet_image bash             