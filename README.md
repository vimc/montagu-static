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

Open http://localhost:80/model-review/test-group and you should get a `401 Unauthorized` error - 
the page is protected by caddy's jwt validation.

Now open the browser console and set a cookie by
```
document.cookies="jwt_token=eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ0ZXN0LnVzZXIiLCJpc3MiOiJ2YWNjaW5laW1wYWN0Lm9yZyIsInRlc3QtZ3JvdXAiOiJ0cnVlIiwidG9rZW5fdHlwZSI6Ik1PREVMX1JFVklFVyIsImV4cCI6MTU0OTQ2NTMxM30.b01DzAVQIBk-jW524ZiUpQ-mljdPDMFzQHD7a8QA_s07GLpGqZFpDBJEkZulxmqhNys-J6KnXzukg_4FOAzAPxRqFeJ_AcSlbSLhh5_XM0vgLzxvj2wYx0mk8V3g9atd-uIgMgJdRjxqNjcv00V6ioaOWGPpuo1Lx6A74-nAGNmTd4i--F7kzuCMRKspdEBDSUYrhdtoXyuo0mV3P1e0hb60SvwkGa60dLcueQmdIDHosNT-ix-2_c2n6JTkpDdLlEw4PzefOx92dDBj_uBuH1Iz5M2uCJHkWiO4BuNGFwR-BkhIa05gMdUBoolY2KHPUXUAiqNYq0Z29hHDKmk2yQ"
```

This sets a cookie that caddy can validate with the public key that is mounted into the container. 
Now going to http://localhost:80/model-review/test-group should give you a regular 404.

At this point nginx is passing the request to caddy, who is validating the jwt.

## Caddyfile
This is generated from the template `caddy/Caddyfile.template` by the script `caddy/generate-caddy-file`