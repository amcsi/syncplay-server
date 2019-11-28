FROM python:3.7-alpine

RUN  apk add --update --progress \
        musl \
        build-base \
        bash \
        git

#ENV PYTHON_PIP_VERSION 8.1.0
RUN pip install -q --no-cache-dir --upgrade pip

RUN pip install twisted

RUN mkdir /app/syncplay -p
RUN git clone https://github.com/Syncplay/syncplay -b v1.6.4a /app/syncplay

EXPOSE 8999
COPY ./entrypoint.sh /entrypoint.sh

# Run as non-root user                                                                                                  
RUN addgroup -g 800 -S syncplay && \
    adduser -u 800 -S syncplay -G syncplay
USER syncplay

WORKDIR /app/syncplay
ENTRYPOINT ["/entrypoint.sh"]
