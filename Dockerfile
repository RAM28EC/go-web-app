FROM golang:1.22.5 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .
#final Image distorless image

#FROM gcr.io/distorless/base(Check the url. You have made a spelling mistake here)
FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=base  /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD [ "./main" ]
