---
to: <%= name %>/src/middlewares/prismaSelect.ts
---

import { PrismaSelect } from '@paljs/plugins'

export const prismaSelect = async (resolve, root, args, context, info) => {
  const result = new PrismaSelect(info).value
  if (!result.select || Object.keys(result.select).length > 0) {
    args = {
      ...args,
      ...result,
    }
  }
  return resolve(root, args, context, info)
}
