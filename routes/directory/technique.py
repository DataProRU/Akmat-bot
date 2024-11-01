from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from models import Techniques, TypeTechniques, Investors


router = APIRouter()

templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

@router.get("/technique", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    techniques = db.query(Techniques).all()
    type_techniques = db.query(TypeTechniques).all()
    investors = db.query(Investors).all()

    return templates.TemplateResponse("directory/technique.html", {
        "request": request,
        "techniques": techniques,
        "type_techniques": type_techniques,
        "investors": investors
    })

@router.post("/technique/edit/{id}", response_class=HTMLResponse)
async def edit_technique(
    request: Request,
    id: int,
    title: str = Form(...),
    type_technique_id: int = Form(...),
    investor_id: int = Form(...),
    visible: bool = Form(False),
    db: Session = Depends(get_db),
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    # Поиск записи по id
    type_to_edit = db.query(Techniques).filter(Techniques.id == id).first()
    if type_to_edit:
        type_to_edit.title = title
        type_to_edit.type_technique_id = type_technique_id
        type_to_edit.investor_id = investor_id
        type_to_edit.visible = visible
        db.commit()

    return RedirectResponse(url="/technique", status_code=303)

@router.post("/technique/add", response_class=HTMLResponse)
async def add_technique(
    request: Request,
    title: str = Form(...),
    type_technique_id: int = Form(...),
    investor_id: int = Form(...),
    visible: bool = Form(False),
    db: Session = Depends(get_db),
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    new_tech = Techniques(title=title,
                           type_technique_id=type_technique_id,
                           investor_id=investor_id,
                          visible = visible)
    db.add(new_tech)
    db.commit()

    return RedirectResponse(url="/technique", status_code=303)
@router.post("/technique/delete/{id}", response_class=HTMLResponse)
async def delete_technique(request: Request, id: int, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    print("delete")

    tech_to_delete = db.query(Techniques).filter(Techniques.id == id).first()
    if tech_to_delete:
        db.delete(tech_to_delete)
        db.commit()

    return RedirectResponse(url="/technique", status_code=303)