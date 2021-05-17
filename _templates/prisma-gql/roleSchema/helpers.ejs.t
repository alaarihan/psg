---
to: <%= options.dir %>/roleSchema/helpers.ts
---

export function camelize(text) {
  text = text.replace(/[-_\s.]+(.)?/g, (_, c) => (c ? c.toUpperCase() : ''))
  return text.substr(0, 1).toLowerCase() + text.substr(1)
}
