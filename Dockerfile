FROM python:3.9.23-bookworm

# WORKDIR .

COPY requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./src /src

EXPOSE 5000
CMD python3 src/app.py
