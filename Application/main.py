import sys

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from prometheus_fastapi_instrumentator import Instrumentator
from loguru import logger as lg

app = FastAPI(debug=True)
lg.add(sys.stderr, format="{time} {level} {message}", filter="my_module", level="INFO", enqueue=True)
lg.info("FastAPI started.")

Instrumentator().instrument(app).expose(app)

origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    try:
        return {"message": "Hello World"}
    except Exception as e:
        lg.warning(e)

