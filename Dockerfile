FROM python:2

RUN apt-get update
RUN apt-get install -y proj-bin python-pip libapr1 libapr1-dev libaprutil1-dev \
  python-dev python-setuptools \
  libffi-dev libxml2-dev libxslt1-dev \
  libtiff-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev \
  liblcms2-dev libwebp-dev python-tk

# RUN pip install meinheld gunicorn
ENV PROXY_PORT=5000

RUN python -m pip install --upgrade pip

WORKDIR /usr/src/app

COPY wmtsproxy ./wmtsproxy
COPY wmtsproxy_restapi ./wmtsproxy_restapi

RUN cd wmtsproxy/ && \
  pip install --no-cache-dir -r requirements.txt && \
  python setup.py install

RUN cd wmtsproxy_restapi/ && \
  pip install --no-cache-dir -r requirements.txt && \
  python setup.py install

# COPY services.csv .
COPY deploy.py .

CMD ["python", "deploy.py"]