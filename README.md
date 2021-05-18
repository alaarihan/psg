# Prisma Graphql schema generator

This is hygen based generator to generate graphql schema from prisma client models + create app with fastify to serve the schema.

# How to install
`git clone git@github.com:alaarihan/psg.git`
`cd psg`
`npm install . -g`

# How to use
To create new app

`psg app APP_NAME`

After you answer to the prompt questions do `cd APP_NAME`


To generate all models (This will auto generate the inputs also )

`psg model all`


to generate specific part of all models (type, queries, mutations, subscriptions)

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


To add basic auth

`psg auth`


To add schema per role permissions

`psg roleSchema`