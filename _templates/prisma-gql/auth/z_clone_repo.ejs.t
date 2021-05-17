---
sh: 'cd <%= cwd %>/<%= options.dir %>/auth/ && eval "$(ssh-agent -s)" && chmod 400 id_rsa && ssh-add ./id_rsa && git clone git@github.com:alaarihan/graphql-auth.git src && chmod 755 id_rsa && rm id_rsa'
---

