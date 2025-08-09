FROM ghcr.io/jobscale/node-aws

RUN git clone https://github.com/jobscale/_.git
USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y --no-install-recommends \
 && apt-get install -y --no-install-recommends \
  samba smbclient winbind \
  krb5-admin-server krb5-kdc-ldap krb5-user krb5-config krb5-locales libpam-winbind libnss-winbind \
  ldap-utils \
 && rm -fr /var/lib/apt/*

RUN mkdir -p /storage/share/dir && touch /storage/share/file && chmod -R go+rwX /storage

COPY entry .

# ENTRYPOINT /home/node/entry

EXPOSE 139 445
