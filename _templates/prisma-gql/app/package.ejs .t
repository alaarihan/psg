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
    "@aws-sdk/client-s3": "^3.23.0",
    "@aws-sdk/lib-storage": "^3.23.0",
    "@paljs/plugins": "^3.6.1",
    "@prisma/client": "^2.27.0",
    "change-case": "^4.1.2",
    "dotenv": "^10.0.0",
    "fastify": "^3.19.2",
    "fastify-cookie": "^5.3.1",
    "fastify-cors": "^6.0.2",
    "fastify-multipart": "^4.0.7",
    "graphql": "^15.5.1",
    "graphql-middleware": "^6.0.10",
    "graphql-scalars": "^1.10.0",
    "jsonwebtoken": "^8.5.1",
    "mercurius": "^8.1.0",
    "sharp": "^0.28.3"
  },
  "devDependencies": {
    "@types/node": "^16.4.3",
    "prettier": "^2.3.1",
    "prisma": "2.27.0",
    "ts-node": "^10.1.0",
    "ts-node-dev": "^1.1.8",
    "typescript": "^4.3.5"
  },
  "prettier": {
    "singleQuote": true,
    "semi": false,
    "trailingComma": "all"
  },
  "repository": "",
  "author": "Alaa Rihan"
}
