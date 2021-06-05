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
    "prisma:generate": "prisma generate",
    "prisma:studio": "prisma studio",
    "prisma:migrate": "prisma migrate dev",
    "prisma:db-push": "prisma db push",
    "prisma:db-pull": "prisma db pull",
    "prettier": "prettier --write src"
  },
  "dependencies": {
    "@paljs/plugins": "^3.3.3",
    "@prisma/client": "^2.24.1",
    "dotenv": "^10.0.0",
    "fastify": "^3.17.0",
    "fastify-cookie": "^5.3.1",
    "fastify-cors": "^6.0.1",
    "graphql": "^15.5.0",
    "graphql-middleware": "^6.0.10",
    "graphql-scalars": "^1.9.3",
    "jsonwebtoken": "^8.5.1",
    "mercurius": "^7.7.0"
  },
  "devDependencies": {
    "@types/node": "^15.6.2",
    "prettier": "^2.3.0",
    "prisma": "2.24.1",
    "ts-node": "^10.0.0",
    "ts-node-dev": "^1.1.6",
    "typescript": "^4.3.2"
  },
  "prettier": {
    "singleQuote": true,
    "semi": false,
    "trailingComma": "all"
  },
  "repository": "",
  "author": "Alaa Rihan"
}
