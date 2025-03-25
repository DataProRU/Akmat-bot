# /server/models.py

from typing import Dict

# Сторонние модули
from pydantic import BaseModel


class SuccessAutoLoadRequest(BaseModel):
    notification_data: Dict[str, str]
    today_date: str


class ChatIdsRequest(BaseModel):
    chat_ids: list[str]