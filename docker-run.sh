docker build -t nginx-rtmp .
docker run -p 1935:1935 -d nginx-rtmp
