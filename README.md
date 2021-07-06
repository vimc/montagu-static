# Authenticated static file server for montagu

This repo mimics most of the setup in montagu where we have:

* Caddy serving static files and doing jwt validation as `static` on `80`
* nginx doing the world-facing proxying as `proxy` on `80`

Caddy is only required because of the jwt validation, which nginx does not support in the free version.

The Caddy and nginx images are built automatically by Buildkite. To run them locally:

```shell
cd nginx/
export GIT_BRANCH_TAG=$(git symbolic-ref --short HEAD)
docker pull vimc/montagu-static:${GIT_BRANCH_TAG}
docker pull vimc/montagu-static-reverse-proxy:${GIT_BRANCH_TAG}
docker-compose up --force-recreate
```

Then try to retrieve a resource that is protected by Caddy's JWT validation:

```shell
curl localhost/model-documentation/2019/HepB-IC-Hallett/mmc1.pdf
```

You should get a `401 Unauthorized` error.

Try again, setting a cookie containing a JWT that Caddy can validate with the public key that is mounted into the container:

```shell
curl localhost/model-documentation/2019/HepB-IC-Hallett/mmc1.pdf -b "jwt_token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJIZXBCIjp0cnVlfQ.JnjXvHpV9m0wQISroc54_R1SiTXi4kHCE4-aiIbl644-MK4-LPSGSgfvKmE5_S0CSTXbF5WTIllyJo7pW2tfyjBNurDOMKdKoRxAr8WofWYQ4Z2_JpXK9d-HSts9Rtl6CoxO0UTOcbcTnA4ldMGlxwG4UVr_DMOujPV94LQrc29lBnGCeWmuI9aMMCM28-y0p3d0G_AuoEXQyzGm3KLvK0K87cdgWaX01hhQZKxyp4qBEF5MNKQeajUJ5kbLzl-7p8OFssyehme-OOHln7wpL5UofrJ_yygyDdYXVShgf1O0XOByQJoUbo3Xbknr2TMo07PKQoehRcSMiWIViVkuGQ"
```

This should give you a regular `404 Not Found`.

## Caddyfile

This is generated from the template `caddy/Caddyfile.template` by the script `caddy/generate-caddy-file`
