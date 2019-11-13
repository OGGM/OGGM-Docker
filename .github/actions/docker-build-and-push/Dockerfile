FROM docker:stable
RUN apk add --no-cache --update bash
COPY build-and-push.sh /build-and-push.sh
ENTRYPOINT ["/build-and-push.sh"]
