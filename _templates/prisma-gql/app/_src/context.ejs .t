---
to: <%= name %>/src/context.ts
---

import { PrismaClient } from '@prisma/client'
import { MercuriusContext } from 'mercurius'

export const prisma = new PrismaClient()
export interface Context {
  prisma: PrismaClient
  user: any
}

export interface AppContext extends MercuriusContext {
  prisma: PrismaClient
  user: any
}

export async function createContext(req, reply?): Promise<Context> {
  return {
    prisma,
    // add_context_items
  }
}
