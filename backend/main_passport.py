from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from passporteye import read_mrz
import shutil
import os

app = FastAPI()

@app.post("/ocr/passport")
async def ocr_passport(file: UploadFile = File(...)):
    # Save the uploaded file to a temporary location
    temp_path = f"/tmp/{file.filename}"
    with open(temp_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    # Run passporteye
    mrz = read_mrz(temp_path)
    os.remove(temp_path)
    if mrz:
        data = mrz.to_dict()
        print('MRZ DATA:', data)
        name = f"{data.get('surname', '').title()} {data.get('names', '').title()}"
        dob = data.get('date_of_birth', '')
        passport_number = data.get('number', '')
        return {
            "name": name.strip(),
            "surname": data.get('surname', '').title(),
            "names": data.get('names', '').title(),
            "date_of_birth": dob,
            "passport_number": passport_number
        }
    else:
        return JSONResponse(status_code=400, content={"error": "No MRZ data found"})