---
to: <%= name %>/src/context.ts
---

import { PrismaClient } from '@prisma/client'
import { MercuriusContext } from 'mercurius'
import { verify } from 'jsonwebtoken'

export const prisma = new PrismaClient()
export interface Context {
  prisma: PrismaClient
  user: any
}

export interface FinalContext extends MercuriusContext {
  prisma: PrismaClient
  user: any
}

function getUserFromHeader(req) {
  let authScope = ''
  let user
  if (req.headers && req.headers.authorization) {
    authScope = req.headers.authorization
  }
  const token = authScope.replace('Bearer ', '')
  if (token.length) {
    user = verify(token, process.env.APP_SECRET)
  }
  return user
}

export function createContext(req, reply, ctx): Context {
  return {
    prisma,
    user: getUserFromHeader(req),
  }
}
