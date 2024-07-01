FROM python:3.10.12

COPY ./app/. ./app/

WORKDIR /app/

RUN  cd /app && pip install -r requirements2.txt

EXPOSE 8001

CMD [ "python3" , "web.py"]