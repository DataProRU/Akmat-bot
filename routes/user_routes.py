from fastapi import APIRouter

router = APIRouter()

# Добавьте маршруты, связанные с пользователями (например, просмотр профиля)
@router.get("/profile")
async def get_profile():
    return {"message": "User profile"}

