FROM python:3.9.23-bookworm

# WORKDIR .

COPY requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./src /src

EXPOSE 8080
CMD python3 src/app.py
