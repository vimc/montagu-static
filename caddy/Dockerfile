# Based on https://github.com/abiosoft/caddy-docker/blob/master/Dockerfile
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Abiola Ibrahim
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Modifications here are to change the plugins, remove git
# installation, and use our own Caddyfile rather than bind mounting
# one in.

FROM nodakai/build-caddy-server as builder

ARG version="1.0.5"
ARG plugins="BTBurke/caddy-jwt"

RUN VERSION=v${version} PLUGINS=${plugins} /root/build.sh

#
# Final stage
#
FROM alpine:3.14

LABEL caddy_version="1.0.5"

# install caddy
COPY --from=builder /root/caddy /usr/bin/caddy

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins

EXPOSE 80
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile
RUN touch /public_key.pem

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
