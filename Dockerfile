FROM golang:1.23 as base
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o main .
FROM gcr.io/distroless/base
COPY /app/main .
COPY --from=base /app/dest/ ./static
EXPOSE 8080
CMD [ "./main" ]

