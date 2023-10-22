FROM alpine:latest

RUN echo "Hello, World!" > /var/www/index.html

CMD ["sh", "-c", "while true; do echo 'HTTP/1.1 200 OK\n\nHello, World!'; done | nc -l -p 80"]
