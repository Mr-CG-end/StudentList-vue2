---
trigger: always_on
---

# Project Tech Stack & Constraints (Vue 2 Legacy)

## 1. Technology Stack

- **Framework**: Vue.js 2.7 (Legacy).
- **UI Library**: Element UI (2.x version).
- **Build Tool**: Webpack / Vue CLI.
- **Styling**: SCSS.

## 2. 🚫 STRICT PROHIBITIONS (绝对禁止)

- **NO** Composition API (`<script setup>`, `ref`, `reactive`).
- **NO** TypeScript syntax.
- **NO** `?.` (Optional Chaining) in `<template>` (Vue 2 templates do not support it).
- **NO** arrow functions in lifecycle hooks or methods (to preserve `this` context).

## 3. Coding Standards (Options API)

All Vue components MUST follow this structure:

```javascript
export default {
  name: "ComponentName",
  // 1. Props & Components
  props: {},
  components: {},
  // 2. Reactive Data
  data() {
    return {
      // Define all variables here
    };
  },
  // 3. Computed & Watch
  computed: {},
  watch: {},
  // 4. Lifecycle (created -> mounted)
  created() {},
  mounted() {},
  // 5. Methods (Business Logic)
  methods: {
    handleEvent() {
      // Use this.variable
    },
  },
};
```

## 4. Specific Patterns (Vue 2 & Element UI)

- **Reactivity**: Use `this.$set(obj, key, val)` for adding properties or modifying array indices.
- **Communication**: Use `this.$emit('event', payload)` for child-to-parent.
- **Element UI**: Use `slot-scope="scope"` for table columns (NOT `v-slot`).
- **Styling**: Use `::v-deep .class` (NOT `:deep(.class)`) to override Element UI styles.
- **Router**: Use `this.$router.push()` (NOT `useRouter`).
