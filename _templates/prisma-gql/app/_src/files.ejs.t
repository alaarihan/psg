---
to: <%= name %>/src/files.ts
---

import { Upload } from '@aws-sdk/lib-storage'
import { prisma } from './prisma'
import { s3 } from './common/s3'
import { uniqueFilePath } from './common/uniqueFilePath'
import { GetObjectCommand } from '@aws-sdk/client-s3'
import sharp from 'sharp'
import { Readable } from 'stream'
import path from 'path'

module.exports = function (fastify, opts, done) {
  fastify.post('/file', async (req, reply) => {
    // before_upload_checks
    
    const data = await req.file()
    if (!data || !data.file) throw new Error('No file to upload')
    const fileName = data.fields?.name?.value || data.filename
    const filePath = req.query?.path
      ? `${req.query.path}/${fileName}`
      : fileName
    const fileKey = await uniqueFilePath(filePath)
    const target = {
      Bucket: process.env.S3_BUCKET_NAME,
      Key: fileKey,
      Body: data.file,
      ContentType: data.mimetype,
      ContentEncoding: data.encoding,
      ACL: 'public-read',
    }
    let fileMeta
    if (Object.keys(data.fields).length > 4) {
      const keys = Object.keys(data.fields).filter(
        (key) => !['relativePath', 'name', 'type', 'file'].includes(key),
      )
      if (keys.length) {
        fileMeta = {}
        keys.forEach((key) => {
          fileMeta[key] = data.fields[key].value
        })
      } else {
        fileMeta = null
      }
    }
    try {
      const parallelUploads3 = new Upload({
        client: s3,
        params: target,
      })

      /*  parallelUploads3.on('httpUploadProgress', (progress) => {
        console.log(progress)
      }) */

      await parallelUploads3.done()
      return prisma.file.create({
        data: {
          name: fileName,
          bucket: process.env.S3_BUCKET_NAME,
          mimeType: data.mimetype,
          path: fileKey,
          meta: fileMeta,
        },
      })
    } catch (e) {
      console.log(e)
      throw new Error('Upload failed!')
    }
  })

  fastify.get('/file/*', async (req, reply) => {
    if (!req.params['*'])
      throw reply.code(404).type('text/plain').send('Not found!')
    const pathParsed = path.parse(req.params['*'])
    if (
      (req.query?.w || req.query?.h) &&
      [
        '.png',
        '.jpg',
        '.jpeg',
        '.gif',
        '.bmp',
        '.svg',
        '.webp',
        '.tif',
        '.tiff',
      ].includes(pathParsed?.ext.toLowerCase())
    ) {
      const object = await getImageSize(req, reply)
      reply.type(object.ContentType)
      reply.headers({
        'Content-Length': object.ContentLength,
        'Content-Encoding': object.ContentEncoding,
      })
      return reply.send(object?.Body)
    }
    const object = await getObjectByKey(req.params['*']).catch((err) => {
      throw reply.code(404).type('text/plain').send('Not found!')
    })
    reply.type(object.ContentType)
    reply.headers({
      'Content-Length': object.ContentLength,
      'Content-Encoding': object.ContentEncoding,
    })
    reply.send(object?.Body)
  })
  done()
}

async function getImageSize(req, reply) {
  const width = req.query?.w ? parseInt(req.query.w) : null
  const height = req.query?.h ? parseInt(req.query.h) : null
  const fit =
    req.query?.fit &&
    ['cover', 'contain', 'fill', 'inside', 'outside'].includes(req.query?.fit)
      ? req.query?.fit
      : null
  let filePath = `thumbnails/${req.params['*']}`
  if (width || height) {
    const thumbName = (width ? `w-${width}` : '') + (height ? `h-${height}` : '') + (fit ? `-${fit}` : '')
    filePath = `${filePath}/${thumbName}`
  }
  const object = await getObjectByKey(filePath).catch(async (err) => {
    if (err.name === 'NoSuchKey') {
      const originalObject = await getObjectByKey(req.params['*']).catch(
        (err) => {
          console.error("Couldn't get the original image to resize!")
          throw err
        },
      )
      if (!originalObject.ContentType.startsWith('image')) {
        return originalObject
      }
      let transform = sharp()
      const options = fit ? { fit } : undefined
      transform = transform.resize(width, height, options)
      const originalImage = originalObject?.Body as Readable
      const target = {
        Bucket: process.env.S3_BUCKET_NAME,
        Key: filePath,
        Body: originalImage.pipe(transform),
        ContentType: originalObject.ContentType,
        ContentEncoding: originalObject.ContentEncoding,
      }

      try {
        const parallelUploads3 = new Upload({
          client: s3,
          params: target,
        })

        await parallelUploads3.done()
        return await getObjectByKey(filePath)
      } catch (e) {
        console.log(e)
        throw new Error('get image failed!')
      }
    }
    throw err
  })

  return object
}

async function getObjectByKey(key) {
  const getObject = new GetObjectCommand({
    Bucket: process.env.S3_BUCKET_NAME,
    Key: key,
  })
  return await s3.send(getObject).then(
    (obj) => obj,
    (err) => {
      throw err
    },
  )
}
