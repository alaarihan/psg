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

export interface AppContext extends MercuriusContext {
  prisma: PrismaClient
  user: any
}

function getUserFromHeaders(req) {
  let user
  const adminSecret = req.headers?.admin_secret
  if (adminSecret) {
    if (adminSecret === process.env.ADMIN_SECRET) {
      const userRole = req.headers?.user_role || 'ADMIN'
      const userId = req.headers?.user_id
      return { id: userId, role: userRole }
    } else {
      throw new Error('Invalid admin secret!')
    }
  }
  let authScope = ''
  if (req.headers && req.headers.authorization) {
    authScope = req.headers.authorization
  } else {
    return { role: process.env.UNAUTHORIZED_ROLE || 'UNAUTHORIZED' }
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
    user: getUserFromHeaders(req),
  }
}
