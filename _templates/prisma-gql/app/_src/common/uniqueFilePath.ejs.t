---
to: <%= name %>/src/common/uniqueFilePath.ts
---

import { HeadObjectCommand } from '@aws-sdk/client-s3'
import path from 'path'
import { s3 } from './s3'

export const uniqueFilePath = async (filePath, index = 0) => {
  const pathParsed = path.parse(filePath)
  let ext = pathParsed.ext
  let filePathWithoutExt = `${pathParsed.dir}/${pathParsed.name}`
  let fullFilepath = index ? `${filePathWithoutExt}-${index}${ext}` : filePath
  const headObject = new HeadObjectCommand({
    Bucket: process.env.S3_BUCKET_NAME,
    Key: fullFilepath,
  })
  const exists = await s3.send(headObject).then(
    () => true,
    (err) => {
      if (err.name === 'NotFound') {
        return false
      }
      throw err
    },
  )
  if (!exists) return fullFilepath

  return await uniqueFilePath(filePath, index + 1)
}
