---
to: <%= name %>/prisma/schema.prisma
---

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

enum UserRole {
  ADMIN
  USER
  BLOCKED
  UNVERIFIED
  UNAUTHORIZED
}

enum PermissionType {
  READ
  CREATE
  UPDATE
  DELETE
}

model Permission {
  id     Int            @id @default(autoincrement())
  active Boolean        @default(true)
  role   UserRole
  type   PermissionType
  model  String         @db.VarChar(100)
  def    Json?

  @@unique([role, type, model])
}

model User {
  id                Int       @id @default(autoincrement())
  email             String    @unique @db.VarChar(100)
  firstName         String?   @db.VarChar(100)
  lastName          String?   @db.VarChar(100)
  password          String
  role              UserRole  @default(UNVERIFIED)
  verificationToken String?
  country           String?   @db.VarChar(150)
  dateOfBirth       DateTime?
  createdAt         DateTime  @default(now())
  updatedAt         DateTime  @updatedAt
  posts             Post[]
}

model Post {
  id         Int        @id @default(autoincrement())
  authorId   Int
  imageId    Int?
  name       String     @db.VarChar(255)
  content    String?
  image      File?      @relation(fields: [imageId], references: [id])
  createdAt  DateTime   @default(now())
  updatedAt  DateTime   @updatedAt
  author     User      @relation(fields: [authorId], references: [id])
  categories Category[]
}

model Category {
  id        Int      @id @default(autoincrement())
  name      String   @db.VarChar(200)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  posts     Post[]
}

model File {
  id        Int      @id @default(autoincrement())
  name      String
  bucket    String
  mimeType  String
  path      String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  meta      Json?
  tags      String[]
  Post Post[]

  @@unique([bucket, path])
}
