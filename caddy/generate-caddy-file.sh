#!/usr/bin/env bash

groups=( test-group
Cambridge-Trotter
CDA-Razavi
JHU-Lessler
LSHTM-Clark
LSHTM-Jit
UND-Moore
UND-Perkins
Emory-Lopman
Harvard-Sweet
IC-Garske
IC-Hallett
JHU-Tam
KPW-Jackson
OUCRU-Clapham
PHE-Vynnycky
PSU-Ferrari )

for i in "${groups[@]}"
do
    echo -e "\njwt {" >> Caddyfile
    echo "    path /$i" >> Caddyfile
    echo "    allow $i true" >> Caddyfile
    echo "    publickey /public_key.pem" >> Caddyfile
    echo "}" >> Caddyfile
done
