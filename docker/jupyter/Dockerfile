FROM python:latest

COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt

COPY start_jupyter /bin/
RUN ["chmod", "+x", "/bin/start_jupyter"]

WORKDIR /workdir

CMD ["start_jupyter"]
