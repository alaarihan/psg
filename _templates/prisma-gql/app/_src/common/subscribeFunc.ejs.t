---
to: <%= name %>/src/common/subscribeFunc.ts
---

export function subscribeFunction(root, args, { pubsub }, info){
    const ext = info.parentType.getFields()[info.fieldName].extensions
    const model = ext.model.toUpperCase()
    return pubsub.subscribe(
      `${model}_CREATED`,
      `${model}_UPDATED`,
      `${model}_DELETED`,
    )
}
