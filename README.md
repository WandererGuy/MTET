# introduction
set up a FastAPI server for serving mTET model for translating English to Vietnamese

# prepare
```
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
pip install transformers
pip install fastapi uvicorn pydantic python-multipart
```


# docker 
to activate server to serve API , you run docker 
```
docker build -t mtet_image .
docker run -it mtet_image bash             
```
# usage 
to translate from english to vietnamese, <br>
API endpoints stored in .\routers\infer.py or open link http://127.0.0.1:4013/docs top see API docs <br>
you can use API now