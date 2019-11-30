FROM alpine:3

RUN apk --update --no-cache add gcc python3 python3-dev musl-dev jq curl bash && \
	ln -sf /usr/bin/python3 /usr/bin/python && \
	ln -sf /usr/bin/pip3 /usr/bin/pip

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
