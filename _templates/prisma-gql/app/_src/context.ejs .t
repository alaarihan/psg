---
to: <%= name %>/src/context.ts
---

import { prisma } from './prisma'
import { PrismaClient } from '@prisma/client'
import { MercuriusContext } from 'mercurius'
import { fns } from './ctxFunctions'


export interface Context {
  prisma: PrismaClient
  user: any
  fns: Record<string, Function>
}

export interface AppContext extends MercuriusContext {
  prisma: PrismaClient
  user: any
  fns: Record<string, Function>
}

export async function createContext(req, reply?): Promise<Context> {
  return {
    prisma,
    fns,
    // add_context_items
  }
}
