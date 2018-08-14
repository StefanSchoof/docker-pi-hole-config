docker-compose pull
docker-compose up -d
docker-compose logs  2>&1| grep "random password"
