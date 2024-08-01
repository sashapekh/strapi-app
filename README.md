# First project with azure stack and github deploy

> Infra code (Docker, Terraform) inside `infra` folder of root project dir


## For dev developing
> you must install Docker, Docker compose, make (for execute Makefile commands)
1. `cp .env.exampe .env`
2. `make up` - command to start Docker Compose services
3. must created and start app and postres services (`docker compose ps` - see status of containers)



## CI\CD alog
1. create latest image for push to `main` branch
2. deploy to azure web app service
3. You can find code in `.github/workflows/main.yml`