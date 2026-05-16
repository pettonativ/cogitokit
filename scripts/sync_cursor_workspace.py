#!/usr/bin/env python3
"""Regenerate .cursor/skills/* symlinks from .agent/skills and extension-kits.

Run from repo root: python3 scripts/sync_cursor_workspace.py
Idempotent; safe to run after pull or when kits change.
"""

from __future__ import annotations

import os
from pathlib import Path


def main() -> None:
    root = Path(__file__).resolve().parent.parent
    skills_dir = root / ".cursor" / "skills"
    skills_dir.mkdir(parents=True, exist_ok=True)

    for p in skills_dir.iterdir():
        if p.is_symlink():
            p.unlink()

    def link(name: str, target: Path) -> None:
        dest = skills_dir / name
        if dest.exists() or dest.is_symlink():
            dest.unlink()
        rel = os.path.relpath(target, skills_dir)
        dest.symlink_to(rel, target_is_directory=True)

    core = root / ".agent" / "skills"
    if core.is_dir():
        for d in sorted(core.iterdir()):
            if not d.is_dir():
                continue
            if d.name == "app-builder":
                continue  # linked as app-builder + app-builder-templates
            if (d / "SKILL.md").is_file():
                link(d.name, d)

    app_builder = core / "app-builder"
    if app_builder.is_dir() and (app_builder / "SKILL.md").is_file():
        link("app-builder", app_builder)

    templates = core / "app-builder" / "templates"
    if templates.is_dir() and (templates / "SKILL.md").is_file():
        link("app-builder-templates", templates)

    kits = root / "extension-kits"
    if kits.is_dir():
        for kit in sorted(kits.iterdir()):
            if not kit.is_dir():
                continue
            for sub in (kit / ".agent" / "skills", kit / ".agents" / "skills"):
                if not sub.is_dir():
                    continue
                for d in sorted(sub.iterdir()):
                    if d.is_dir() and (d / "SKILL.md").is_file():
                        link(f"ext-{kit.name}-{d.name}", d)

    n = sum(1 for p in skills_dir.iterdir() if p.is_symlink())
    print(f"sync_cursor_workspace: {n} skill symlinks under .cursor/skills/")


if __name__ == "__main__":
    main()
