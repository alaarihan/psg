---
inject: true
to: <%= options.dir %>/schema.ts
after: "merge_the_query_fields_here"
skip_if: "me:"
---

    me: {
      type: GraphQLString,
    },