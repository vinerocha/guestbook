FROM golang as builder
RUN go get github.com/codegangsta/negroni
RUN go get github.com/gorilla/mux github.com/xyproto/simpleredis
COPY main.go .
RUN go build main.go

FROM busybox:ubuntu-14.04

COPY --from=builder /go//main /app/guestbook

ADD index.html /app/index.html
ADD script.js /app/script.js
ADD style.css /app/style.css

WORKDIR /app
CMD ["./guestbook"]
EXPOSE 3000
