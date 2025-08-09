# Samba Active Directory

```bash
docker build . -t local/samba \
&& docker run --name samba -p 445:445 -v $(pwd):/storage -d local/samba
```

