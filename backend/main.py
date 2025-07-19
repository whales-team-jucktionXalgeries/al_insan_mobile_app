import cv2, numpy as np, easyocr, re
from fastapi import FastAPI, File, UploadFile, Form, HTTPException
from fastapi.responses import JSONResponse

app = FastAPI()

# — Preprocessing adapted to bytes —
def preprocess_image_bytes(image_bytes: bytes) -> np.ndarray:
    nparr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8,8))
    clahe_img = clahe.apply(gray)
    bright = cv2.convertScaleAbs(clahe_img, alpha=1.2, beta=30)
    return cv2.GaussianBlur(bright, (3, 3), 0)

# — OCR extraction identical to your extract_text —
def ocr_extract(image_np: np.ndarray):
    reader = easyocr.Reader(['fr'])
    results = reader.readtext(image_np)
    text = "\n".join([t for (_, t, _) in results])
    return text, results

# — Exact same regex + keyword/fallback logic —
amount_re = re.compile(r'(?:(?:\d{1,3}(?:[.,\s]\d{3})*)|\d+)[.,]\d{2}')

def find_total(text: str):
    lines = text.splitlines()
    # 1) keyword scan
    for line in lines:
        if re.search(r'\b(total|montant|à payer|ttc)\b', line, flags=re.IGNORECASE):
            m = amount_re.search(line)
            if m:
                val = m.group(0).replace(' ', '').replace(',', '.')
                try:
                    return float(val)
                except ValueError:
                    pass
    # 2) fallback to max
    candidates = []
    for line in lines:
        for m in amount_re.finditer(line):
            val = m.group(0).replace(' ', '').replace(',', '.')
            try:
                candidates.append(float(val))
            except ValueError:
                pass
    return max(candidates) if candidates else None

# — Your compare-total endpoint —
@app.post("/compare-total")
async def compare_total(
    receipt: UploadFile = File(...),
    user_amount: float      = Form(...)
):
    img_bytes = await receipt.read()
    img_np    = preprocess_image_bytes(img_bytes)

    text, _  = ocr_extract(img_np)
    detected = find_total(text)
    if detected is None:
        raise HTTPException(422, "Could not detect total on receipt")

    # Only compare the integer (whole) part
    detected_int = int(detected)
    user_int = int(user_amount)
    match = detected_int == user_int
    return JSONResponse({
        "match":    match,
        "detected": detected,
        "user":     user_amount,
        "detected_int": detected_int,
        "user_int": user_int
    })
