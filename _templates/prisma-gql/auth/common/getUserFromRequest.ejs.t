---
to: <%= options.dir %>/common/getUserFromRequest.ts
---

import { verify, sign } from 'jsonwebtoken'
import { prisma } from '../prisma'

export function setTokenCookie(user, reply) {
  const token = sign({ id: user.id, role: user.role }, process.env.JWT_SECRET, {
    expiresIn: '6m',
  })
  reply.setCookie('authorization', `Bearer ${token}`, {
    path: '/',
    httpOnly: true,
    secure: true,
    sameSite: 'none',
    maxAge: 60 * 5, // 5 minutes
  })

  return token
}

export async function getUserFromRequest(req, reply) {
    let user
    const rootSecret = req.cookies?.root_secret || req.headers['root-secret']
    if (rootSecret) {
      if (rootSecret === process.env.ROOT_SECRET) {
        const userRole = req.headers['user-role'] || 'ROOT'
        const userId = req.headers['user-id']
        return { id: userId, role: userRole }
      } else {
        throw new Error('Invalid root secret!')
      }
    }
    const refresh_token = req.cookies?.refresh_token
    let authToken = req.cookies?.authorization
    if (authToken?.length) {
      const token = authToken.replace('Bearer ', '')
      try {
        user = verify(token, process.env.JWT_SECRET)
      } catch (err) {
        throw new Error('Invalid JWT token!')
      }
    } else if (!refresh_token) {
      return { role: process.env.UNAUTHORIZED_ROLE || 'UNAUTHORIZED' }
    }
  
    if (!authToken?.length && refresh_token?.length) {
      try {
        let refreshUser = verify(refresh_token, process.env.JWT_SECRET)
        refreshUser = await prisma.user.findUnique({
          where: { id: refreshUser.id },
        })
        if (refreshUser) {
          user = { id: refreshUser.id, role: refreshUser.role }
          if (reply) {
            setTokenCookie(user, reply)
          }
        } else {
          if (reply) {
            reply.setCookie('refresh_token', '')
          }
          throw new Error('User not exist!')
        }
      } catch (err) {
        console.log(err)
        throw new Error('Invalid refresh token!')
      }
    }
    return user
  }