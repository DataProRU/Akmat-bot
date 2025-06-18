# Dockerfile (вариант с HTTP-индексом)
FROM python:3.10-slim

WORKDIR /app

# (Опционально) Прокси:
ARG HTTP_PROXY
ARG HTTPS_PROXY
ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}

# Копируем requirements.txt
COPY requirements.txt ./

# Обновляем pip и ставим зависимости через HTTP-зеркало:
RUN pip install --no-cache-dir --upgrade pip \
    --index-url http://pypi.tuna.tsinghua.edu.cn/simple \
    --trusted-host pypi.tuna.tsinghua.edu.cn \
 && pip install --no-cache-dir \
    --index-url http://pypi.tuna.tsinghua.edu.cn/simple \
    --trusted-host pypi.tuna.tsinghua.edu.cn \
    --default-timeout=60 \
    -r requirements.txt

# Копируем остальной код
COPY . .

CMD ["python", "main.py"]
