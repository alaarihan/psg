---
to: <%= name %>/tsconfig.json
unless_exists: true
---

{
  "compilerOptions": {
    "module": "es6",
    "esModuleInterop": true,
    "target": "es6",
    "noImplicitAny": false,
    "moduleResolution": "node",
    "sourceMap": true,
    "outDir": "dist",
    "strictNullChecks": false,
    "skipLibCheck": true
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist"]
}
