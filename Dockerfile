FROM python:3.7-alpine as build

RUN apk add --no-cache --progress \
        build-base \
        cargo \
        curl \
        libffi-dev \
        openssl-dev

WORKDIR /wheels
RUN pip install -U pip
RUN curl -L https://raw.githubusercontent.com/Syncplay/syncplay/v1.6.7/requirements.txt | \
    pip wheel -r /dev/stdin

FROM python:3.7-alpine

RUN  apk add --no-cache --update --progress \
        git \
        openssl \
        libffi

COPY --from=build /wheels /wheels
WORKDIR /wheels
RUN pip install *.whl

RUN mkdir /app/syncplay -p
RUN git clone https://github.com/Syncplay/syncplay -b v1.6.7 /app/syncplay

EXPOSE 8999
COPY ./entrypoint.sh /entrypoint.sh

# Run as non-root user                                                                                                  
RUN addgroup -g 800 -S syncplay && \
    adduser -u 800 -S syncplay -G syncplay && \
    chown -R syncplay:syncplay /app/syncplay

USER syncplay

WORKDIR /app/syncplay
ENTRYPOINT ["/entrypoint.sh"]
