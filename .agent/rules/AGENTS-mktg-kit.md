---
trigger: model_decision
description: "Skills registry for the mktg-kit. Load when user request involves SEO, LinkedIn content, marketing strategy, content creation, or social media optimization."
---

# AGENTS.md — Marketing Kit

> Extension kit skills for marketing and SEO. No dedicated agents — provides skills for content and search optimization.

## Skills Available

When `mktg-kit` is present in the workspace, these skills are auto-discovered:
- SEO optimization (meta tags, schema markup, sitemap)
- LinkedIn content strategy
- Marketing copy generation
- Analytics and conversion optimization

## Routing Protocol

1. Detect marketing/SEO keywords → Check if `mktg-*` skills exist in session context
2. If found → Load and apply
3. If NOT found → General knowledge + inform user the kit is missing
