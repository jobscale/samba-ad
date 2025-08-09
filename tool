#!/usr/bin/env bash

ldap-test-admin() {
  NBIOS_NAME=ldap
  USER_NAME=smb-adm

  ldapsearch -H ldap://ldap.jsx.jp \
  -D "cn=${USER_NAME},dc=${NBIOS_NAME},dc=jsx,dc=jp" \
  -W -b "dc=${NBIOS_NAME},dc=jsx,dc=jp" "(cn=${USER_NAME})"
}

ldap-test-user() {
  NBIOS_NAME=ldap
  USER_NAME=username

  ldapsearch -H ldap://ldap.jsx.jp \
  -D "cn=${USER_NAME},dc=${NBIOS_NAME},dc=jsx,dc=jp" \
  -W -b "dc=${NBIOS_NAME},dc=jsx,dc=jp" "(cn=${USER_NAME})"
}

run-docker() {
  docker build . -t local/samba \
  && docker rm -f samba \
  && docker run --name samba \
  -p 139:139 \
  -p 139:139/udp \
  -p 445:445 \
  -p 445:445/udp \
  -v $PWD/smb.conf:/etc/samba/smb.conf \
  -v $PWD/krb5.conf:/etc/krb5.conf \
  -v $PWD/tool:/home/node/tool \
  -v $PWD/storage:/storage \
  -it local/samba bash
}

smb-restart() {
  /etc/init.d/smbd restart
}

smb-permmission() {
  chmod -R go+rwX /storage
}

{
  grep '^[a-z]' tool
}
