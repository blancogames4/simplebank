# Build Stage
FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.18.1/migrate.linux-amd64.tar.gz | tar xvz



# Run Stage
FROM alpine
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration

# Ensure start.sh is executable
RUN chmod +x /app/start.sh
RUN chmod +x /app/wait-for.sh

EXPOSE 8081
CMD [ "/app/main"]
ENTRYPOINT ["/app/start.sh"]