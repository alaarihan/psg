---
inject: true
to: <%= options.dir %>/context.ts
after: "MercuriusContext"
skip_if: "getUserFromCookies"
---

import { verify, sign } from 'jsonwebtoken'

export function setTokenCookie(user, reply) {
  const token = sign(
    { id: user.id, role: user.role },
    process.env.API_SECRET,
    {
      expiresIn: '6m',
    },
  )
  reply.setCookie('authorization', `Bearer ${token}`, {
    path: '/',
    httpOnly: true,
    secure: true,
    sameSite: 'none',
    maxAge: 60 * 5, // 5 minutes
  })

  return token
}


async function getUserFromCookies(req, reply) {
  let user
  const adminSecret = req.cookies?.admin_secret
  if (adminSecret) {
    if (adminSecret === process.env.ADMIN_SECRET) {
      const userRole = req.headers?.user_role || 'ADMIN'
      const userId = req.headers?.user_id
      return { id: userId, role: userRole }
    } else {
      throw new Error('Invalid admin secret!')
    }
  }
  const refresh_token = req.cookies?.refresh_token
  let authToken = req.cookies?.authorization
  if (authToken?.length) {
    const token = authToken.replace('Bearer ', '')
    try {
      user = verify(token, process.env.API_SECRET)
    } catch (err) {
      throw new Error('Invalid JWT token!')
    }
  } else if (!refresh_token) {
    return { role: process.env.UNAUTHORIZED_ROLE || 'UNAUTHORIZED' }
  }

  if (!authToken?.length && refresh_token?.length) {
    try {
      let refreshUser = verify(refresh_token, process.env.API_SECRET)
      refreshUser = await prisma.user.findUnique({ where: { id: refreshUser.id } })
      if (refreshUser) {
        user = { id: refreshUser.id, role: refreshUser.role }
        setTokenCookie(user, reply)
      }
    }
    catch (err) {
      console.log(err)
      throw new Error('Invalid refresh token!')
    }
  }
  return user
}
