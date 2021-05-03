---
to: <%= name %>/package.json
unless_exists: true
---

{
  "name": "psg-app",
  "version": "1.0.0",
  "main": "dist/server.js",
  "license": "MIT",
  "private": true,
  "description": "Prisma Schema generator App",
  "scripts": {
    "start": "node dist/server",
    "dev": "ts-node-dev --no-notify --respawn --transpile-only --exit-child src/server",
    "clean": "rm -rf dist",
    "build": "npm -s run clean && tsc",
    "generate:prisma": "prisma generate",
    "create-migration": "prisma migrate dev",
    "db-push": "prisma db push --preview-feature",
    "db-pull": "prisma db pull",
    "generate:models": "node index",
    "prettier": "prettier --write src/"
  },
  "dependencies": {
    "@prisma/client": "^2.21.2",
    "fastify": "^3.14.2",
    "graphql": "^15.5.0",
    "graphql-scalars": "^1.9.1",
    "graphql-tools": "^7.0.4",
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