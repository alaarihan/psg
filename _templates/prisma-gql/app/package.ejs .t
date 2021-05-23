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
    "start": "node -r dotenv/config dist/server",
    "dev": "ts-node-dev -r dotenv/config --no-notify --respawn --transpile-only --exit-child src/server",
    "clean": "rm -rf dist",
    "build": "npm -s run clean && tsc",
    "generate:prisma": "prisma generate",
    "create-migration": "prisma migrate dev",
    "db-push": "prisma db push",
    "db-pull": "prisma db pull",
    "prettier": "prettier --write src"
  },
  "dependencies": {
    "@paljs/plugins": "^3.3.3",
    "@prisma/client": "^2.23.0",
    "dotenv": "^9.0.2",
    "fastify": "^3.15.1",
    "fastify-cors": "^6.0.1",
    "graphql": "^15.5.0",
    "graphql-middleware": "^6.0.10",
    "graphql-scalars": "^1.9.3",
    "jsonwebtoken": "^8.5.1",
    "mercurius": "^7.6.1"
  },
  "devDependencies": {
    "@types/node": "^15.6.0",
    "prettier": "^2.3.0",
    "prisma": "2.23.0",
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
