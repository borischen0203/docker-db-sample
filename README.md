# docker-db-sample
![](https://miro.medium.com/v2/resize:fit:656/0*3nbGUAgh6fFop3qB.)

This sample mainly set up `mysql` database by docker.
# How to use

#### Required:
- Install `docker`
- Install `make` command(https://formulae.brew.sh/formula/make)
```bash
brew install make
```

#### Setup your configuration:
Below is a java `application.properties` sample
```bash
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/testDB
spring.datasource.username=root
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.MySQL5InnoDBDialect
spring.jpa.hibernate.ddl-auto=update
```
- `localhost:3306`  should be same as `ports` in docker-compose.yml
- `testDB` is database name, it should be same as `MYSQL_DATABASE`  in docker-compose.yml
- `password` is tha password value, it should be same as `MYSQL_ROOT_PASSWORD` in docker-compose.yml

```yml
version: '3.7'

services:
  mysql:
    image: mysql:5.7
    platform: linux/amd64
    restart: unless-stopped
    container_name: docker-mysql
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: testDB
    ports:
      - "3306:3306"
```

---

### Run steps
Step 1: Clone the repo
```bash
git clone https://github.com/borischen0203/docker-db-sample.git
```

Step 2: Run the container
```bash
make docker-up
```
Or
```bash
docker compose -f docker-compose.yml up -d --build
```
---
### Run demo:
- Use `make docker-up` to run the container
```bash
$ make docker-up
Run docker container - docker-mysql!
docker compose -f docker-compose.yml up -d --build
[+] Running 2/2
 ✔ Network docker-db-sample_default  Created  
 ✔ Container docker-mysql            Started 
```
---
- Use `make docker-exec` to into the container
```bash
$ make docker-exec                                                 
Run docker exec command into container - docker-mysql
docker exec -it docker-mysql /bin/sh
```
Then, you can use below way to into mysql \
`-u`: means username, we use `root` here \
`-p`: means user password, same as you set up in `docker-compose.yml`'s `MYSQL_ROOT_PASSWORD`
```
# mysql -uroot -ppassword
# mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.37 MySQL Community Server (GPL)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.
mysql> 
```

---

- Use `make docker-down` to stop the container
```bash
$ make docker-down 
Terminate docker container - docker-mysql
docker-compose -f docker-compose.yml down
[+] Running 2/1
 ✔ Container docker-mysql            Removed           
 ✔ Network docker-db-sample_default  Removed 
docker system prune
WARNING! This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all dangling images
  - all dangling build cache

Are you sure you want to continue? [y/N] y
Total reclaimed space: 0B
```
---
Option:
You can use `volumes` and `dump.sql`(File location: /docker/mysql/dump.sql) to set up a default table in DB
```yml
volumes:
  - "./docker/mysql/dump.sql:/docker-entrypoint-initdb.d/dump.sql"
```
