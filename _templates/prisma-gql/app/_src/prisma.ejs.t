---
to: <%= name %>/src/prisma.ts
---

import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

// add_prisma_middlewares

export { prisma }
