from fastapi import APIRouter
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from fastapi import  Request

router = APIRouter()

templates = Jinja2Templates(directory="templates")
@router.get("/operations", response_class=HTMLResponse)
async def directory(request: Request):

    return templates.TemplateResponse("directory/operations.html", {
        "request": request,
    })