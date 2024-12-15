# /server/models.py

# Сторонние модули
from pydantic import BaseModel


class ChatIdsRequest(BaseModel):
    chat_ids: list[str]