# Authenticated static file server for montagu

This repo mimics most of the setup in montagu where we have:

* caddy serving static files and doing jwt validation as `static` on `80`
* nginx doing the world-facing proxying as `proxy` on `80`

Caddy is only required because of the jwt validation, which nginx does not support in the free version.

Within `nginx/` run

```
./build.sh
export GIT_BRANCH_TAG=$(git symbolic-ref --short HEAD)
docker pull docker.montagu.dide.ic.ac.uk:5000/montagu-static:${GIT_BRANCH_TAG}
docker pull docker.montagu.dide.ic.ac.uk:5000/montagu-static-reverse-proxy:${GIT_BRANCH_TAG}
docker-compose up --force-recreate
```

Open http://localhost:80/model-review/2019/IC-Garske/test.html and you should get a `401 Unauthorized` error - 
the page is protected by caddy's jwt validation.
