#!/usr/bin/env python3
"""Validate all symlinks in .agent/skills/ and .cursor/skills/ resolve correctly.

Usage:
    python3 scripts/validate_symlinks.py

Returns exit code 1 if any broken symlinks are found.
"""

from pathlib import Path
import sys


def validate_dir(skills_dir: Path) -> list[str]:
    """Check all symlinks in a directory and return list of broken ones."""
    broken = []
    if not skills_dir.is_dir():
        return broken
    for p in sorted(skills_dir.iterdir()):
        if p.is_symlink() and not p.resolve().exists():
            target = p.readlink()
            broken.append(f"  BROKEN: {p.name} -> {target}")
    return broken


def main() -> None:
    root = Path(__file__).resolve().parent.parent
    
    agent_skills = root / ".agent" / "skills"
    cursor_skills = root / ".cursor" / "skills"
    
    all_broken: list[str] = []
    
    print("Validating .agent/skills/ symlinks...")
    broken = validate_dir(agent_skills)
    if broken:
        all_broken.extend(broken)
        print(f"  ❌ {len(broken)} broken symlinks found")
    else:
        total = sum(1 for p in agent_skills.iterdir() if p.is_symlink())
        print(f"  ✅ All {total} symlinks valid")
    
    print("Validating .cursor/skills/ symlinks...")
    broken = validate_dir(cursor_skills)
    if broken:
        all_broken.extend(broken)
        print(f"  ❌ {len(broken)} broken symlinks found")
    else:
        total = sum(1 for p in cursor_skills.iterdir() if p.is_symlink())
        print(f"  ✅ All {total} symlinks valid")
    
    if all_broken:
        print(f"\n❌ Total broken symlinks: {len(all_broken)}")
        for b in all_broken:
            print(b)
        sys.exit(1)
    else:
        print("\n✅ All symlinks are valid!")
        sys.exit(0)


if __name__ == "__main__":
    main()
