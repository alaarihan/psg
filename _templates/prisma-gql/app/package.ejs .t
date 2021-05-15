---
to: <%= name %>/package.json
unless_exists: true
---

{
  "name": "<%= appName %>",
  "version": "1.0.0",
  "main": "dist/server.js",
  "license": "MIT",
  "private": true,
  "description": "<%= appDescription %>",
  "scripts": {
    "start": "node dist/server",
    "dev": "ts-node-dev --no-notify --respawn --transpile-only --exit-child src/server",
    "clean": "rm -rf dist",
    "build": "npm -s run clean && tsc",
    "generate:prisma": "prisma generate",
    "create-migration": "prisma migrate dev",
    "db-push": "prisma db push --preview-feature",
    "db-pull": "prisma db pull",
    "prettier": "prettier --write src"
  },
  "dependencies": {
    "@paljs/plugins": "^3.0.11",
    "@prisma/client": "^2.21.2",
    "fastify": "^3.14.2",
    "graphql": "^15.5.0",
    "graphql-middleware": "^6.0.10",
    "graphql-scalars": "^1.9.1",
    "mercurius": "^7.4.0",
    "prisma-gql-role-schema": "alaarihan/prisma-gql-role-schema#main"
  },
  "devDependencies": {
    "@types/node": "^15.0.1",
    "prettier": "^2.2.1",
    "prisma": "2.21.2",
    "ts-node": "^9.1.1",
    "ts-node-dev": "^1.1.6",
    "typescript": "^4.2.4"
  },
  "prettier": {
    "singleQuote": true,
    "semi": false,
    "trailingComma": "all"
  },
  "repository": "",
  "author": "Alaa Rihan"
}
