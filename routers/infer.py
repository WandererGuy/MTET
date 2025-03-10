from fastapi import FastAPI, HTTPException, Form, APIRouter
from routers.model import MyHTTPException, \
                        my_exception_handler, \
                        reply_bad_request, \
                        reply_server_error, \
                        reply_success
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
import torch 
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print (device)

model_name = "VietAI/envit5-translation"
tokenizer = AutoTokenizer.from_pretrained(model_name)  
model = AutoModelForSeq2SeqLM.from_pretrained(model_name)
model.cuda()


router = APIRouter()

@router.post("/translate_en")
async def translate_en(
    language: str = Form(...),
    inputs: str = Form(...)
):
    # new = []
    # with open(input_text_file, "r") as f:
    #     input_text_lines = f.readlines()
    #     for line in input_text_lines:
    #         line = line.strip()
            
    #         if not line.endswith("."):
    #             line += "."
    #         new.append(line)
    # input_text = " ".join(input_text_lines)
    # inputs = input_text
    if language == "en":
        text = list("en: " + inputs)
    else: 
        return inputs
    outputs = model.generate(tokenizer(inputs, return_tensors="pt", padding=True).input_ids.to('cuda'), max_length=512)
    text = tokenizer.batch_decode(outputs, skip_special_tokens=True)
    res = text[0].replace("vi: ", "")
    return reply_success(message="Success", result=res)
