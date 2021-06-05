# Prisma GraphQL Schema Generator

This is hygen based generator to generate graphql schema from prisma client models + create app with fastify to serve the schema.

# How to install it
`git clone git@github.com:alaarihan/psg.git`

`cd psg`

`npm install`

`npm run build`

`npm install . -g`


# How to use it
To create a new app

`psg app APP_NAME`

After you answer the prompt questions do the following 

`cd APP_NAME`

`npm install`

And don't forget to rename `.env-example` to `.env` and update the file values


To generate all models (This will auto generate the inputs also )

`psg model all`


To generate specific part of all models (type, queries, mutations, subscriptions)

`psg model:type all`

`psg model:queries all`

...etc


To generate specific model by name

`psg model MODEL_NAME`


To generate only specific part of a model (type, queries, mutations, subscriptions)

`psg model:type MODEL_NAME`

`psg model:queries MODEL_NAME`

... etc


To generate inputs

`psg inputs`


To add basic auth and filtering the schema per user permissions

`psg auth`
