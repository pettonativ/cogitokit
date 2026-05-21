---
trigger: model_decision
description: "Skills & Agents registry for the mktg-kit. Load when user request involves SEO, LinkedIn content, marketing strategy, content creation, or social media optimization."
---

# AGENTS.md — Marketing Kit

> Extension kit for marketing and SEO, including search optimization skills and dedicated marketing agents.

## Agents Available

When `mktg-kit` is present in the workspace, these agents are auto-discovered:

| Agent | Focus | Key Skills | Trigger Keywords |
|-------|-------|------------|------------------|
| `seo-specialist` | SEO & GEO (Generative Engine Optimization) expert | seo-fundamentals, geo-fundamentals, clean-code | "seo", "audit", "meta tags", "sitemap", "structured data", "citations" |
| `linkedin-specialist` | Professional brand & LinkedIn content strategist | linkedin-copywriting, personal-branding | "linkedin", "post", "social media", "copywriting", "hook" |

## Skills Available

These skills are also auto-discovered:
- SEO optimization (meta tags, schema markup, sitemap, core web vitals)
- LinkedIn content strategy and copywriting hooks
- Generative Engine Optimization (GEO) for AI search citations
- Marketing copy generation and conversions

## Routing Protocol

1. Detect marketing/SEO keywords → Check if `mktg-*` or `seo-specialist` is requested.
2. If agent is requested or detected → Route to `seo-specialist` or `linkedin-specialist`.
3. If only skills are needed → Load appropriate marketing skills into the current session context.
4. If NOT found → Inform user that `mktg-kit` is missing.
