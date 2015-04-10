docker build -t nginx-rtmp .
docker run -p 80:80 -p 1935:1935 -d nginx-rtmp
