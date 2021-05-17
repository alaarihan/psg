---
sh: 'cd <%= cwd %>/<%= options.dir %>/roleSchema/ && eval "$(ssh-agent -s)" && chmod 400 id_rsa && ssh-add ./id_rsa && git clone git@github.com:alaarihan/prisma-gql-role-schema.git src && chmod 755 id_rsa && rm id_rsa'
---

