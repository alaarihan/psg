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
    "start": "NODE_ENV=production node -r dotenv/config dist/server",
    "dev": "nodemon --ext ts --exec \"npm -s run compile && NODE_ENV=development npm start\"",
    "clean": "rm -rf dist",
    "build": "npm -s run clean && npm -s run compile",
    "compile": "swc src -d dist --config-file swcrc.json",
    "prisma:generate": "prisma generate",
    "prisma:studio": "prisma studio",
    "prisma:migrate": "prisma migrate dev",
    "prisma:db-push": "prisma db push",
    "prisma:db-pull": "prisma db pull",
    "prettier": "prettier --write src"
  },
  "dependencies": {
    "@aws-sdk/client-s3": "^3.39.0",
    "@aws-sdk/lib-storage": "^3.39.0",
    "@fastify/cookie": "^7.0.0",
    "@fastify/cors": "^8.0.0",
    "@fastify/multipart": "^7.1.0",
    "@paljs/plugins": "^4.0.18",
    "@prisma/client": "^4.1.0",
    "change-case": "^4.1.2",
    "dotenv": "^16.0.0",
    "fastify": "^4.2.0",
    "graphql": "^15.7.2",
    "graphql-middleware": "^6.1.11",
    "graphql-scalars": "^1.13.1",
    "jsonwebtoken": "^8.5.1",
    "mercurius": "^10.1.0",
    "sharp": "^0.30.7"
  },
  "devDependencies": {
    "@prisma/internals": "^4.1.0",
    "@swc/cli": "^0.1.57",
    "@swc/core": "^1.2.218",
    "@types/node": "^18.0.6",
    "nodemon": "^2.0.15",
    "prettier": "^2.7.1",
    "prisma": "^4.1.0",
    "typescript": "^4.7.4"
  },
  "prettier": {
    "singleQuote": true,
    "semi": false,
    "trailingComma": "all"
  },
  "repository": "",
  "author": "Alaa Rihan"
}
