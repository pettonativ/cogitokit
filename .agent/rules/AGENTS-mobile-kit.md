---
trigger: model_decision
description: "Agent registry for the mobile-kit. Load when user request involves React Native, Flutter, iOS, Android, Expo, mobile app development, or native mobile features."
---

# AGENTS.md — Mobile Kit

> Extension kit agents for mobile app development.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `mobile-developer` | React Native, Flutter, iOS, Android | mobile-patterns, expo-config, native-modules | "react native", "flutter", "ios", "android", "expo", "mobile app", "native" |

## Routing Extensions

When these keywords are detected, route to `mobile-developer`:
- react native, flutter, ios, android, expo, mobile app, native
- screen, navigation, touch, gesture, push notification, deep link

## Boundary Rules

| CAN Do | CANNOT Do |
|--------|-----------|
| RN/Flutter components, mobile UX, navigation | ❌ Web components (use `frontend-specialist`) |
| Mobile-specific APIs, native modules | ❌ Backend API logic |
| Mobile state management, offline storage | ❌ CI/CD pipelines |

> **Note:** `mobile-developer` is full-stack for mobile projects — handles UI, state, and local data.
