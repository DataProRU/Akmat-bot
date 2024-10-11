bild docker image
docker build -t my-python-app .  

run docker image
docker run -d -p 8000:8000 my-python-app  

run docker image with reload
docker run -v $(pwd):/app -p 8000:8000 my-python-app uvicorn main:app --host 0.0.0.0 --port 8000 --reload

all routers
http://127.0.0.1:8000/docs