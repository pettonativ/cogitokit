# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2025-05-16

### Added
- **Core Framework**: 9 specialist agents, 31 core skills, 20 workflows, 15 rules
- **Extension Kits**: 13 modular kits (frontend, backend, mobile, devops, security, qa, ai, aws, azure, gcp, compliance, hr, mktg)
- **Editor Support**: Bridge files for Cursor, Claude Code, Continue, Gemini CLI / Antigravity
- **Validation Scripts**: `validate_symlinks.py` and `sync_cursor_workspace.py`
- **CI**: GitHub Action for automatic symlink validation on PRs
- **Documentation**: README, CONTRIBUTING guide, issue templates

### Changed
- **Skill Reorganization**: Moved `web-design-guidelines` and `i18n-localization` from core to `frontend-kit` (they are technical implementation skills, not management)
- **Skill Promotion**: Promoted `quality-management` (from `qa-kit`) and `release-planning` (from `devops-kit`) to core (they are PM/governance processes)
- **Credits**: Fixed upstream reference to `vudovn/antigravity-kit`

### Removed
- Client-specific workflows and scripts (not part of the open-source framework)
- Legacy `ui-ux-pro-max` shared data directory
- Legacy `ARCHITECTURE.md` (superseded by per-kit ARCHITECTURE files)
