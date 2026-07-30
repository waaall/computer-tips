#!/usr/bin/env python3
"""Check local links in Markdown files without network access."""

from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import unquote, urlsplit


ROOT = Path(__file__).resolve().parents[1]
INLINE_LINK_RE = re.compile(r"!?\[[^\]\n]*\]\((?P<target>[^)\n]*)\)")
HTML_SOURCE_RE = re.compile(
    r"""<(?:img|source)\s+[^>]*?\b(?:src|href)=["'](?P<target>[^"']+)["']""",
    re.IGNORECASE,
)
REFERENCE_RE = re.compile(
    r"""^\s{0,3}\[[^\]]+\]:\s*(?P<target><[^>]+>|\S+)""",
    re.IGNORECASE,
)
INLINE_CODE_RE = re.compile(r"`+[^`]*`+")
FENCE_RE = re.compile(r"^\s{0,3}(`{3,}|~{3,})")
REMOTE_SCHEMES = {"data", "http", "https", "javascript", "mailto", "tel"}


@dataclass(frozen=True)
class Problem:
    source: Path
    line: int
    message: str

    def __str__(self) -> str:
        relative = self.source.relative_to(ROOT)
        return f"{relative}:{self.line}: {self.message}"


def markdown_files() -> list[Path]:
    return sorted(
        path
        for path in ROOT.rglob("*.md")
        if ".git" not in path.relative_to(ROOT).parts
    )


def repository_paths() -> set[str]:
    return {
        path.relative_to(ROOT).as_posix()
        for path in ROOT.rglob("*")
        if ".git" not in path.relative_to(ROOT).parts
    }


def clean_target(raw_target: str) -> str:
    target = raw_target.strip()
    if target.startswith("<"):
        closing = target.find(">")
        return target[1:closing] if closing >= 0 else target

    # Unescaped spaces delimit an optional Markdown link title. Paths containing
    # spaces should use %20 or angle brackets.
    return target.split(maxsplit=1)[0] if target else ""


def check_target(
    source: Path,
    line_number: int,
    raw_target: str,
    known_paths: set[str],
) -> Problem | None:
    target = clean_target(raw_target)
    if not target:
        return Problem(source, line_number, "empty link target")
    if target.casefold().startswith("(null"):
        return Problem(source, line_number, "invalid '(null)' link target")

    parsed = urlsplit(target)
    if parsed.scheme.casefold() in REMOTE_SCHEMES or target.startswith("#"):
        return None
    if parsed.scheme:
        return Problem(source, line_number, f"unsupported link scheme: {parsed.scheme}")

    path_text = unquote(parsed.path)
    if not path_text:
        return None

    candidate = (source.parent / Path(path_text.replace("\\", "/"))).resolve()
    try:
        relative = candidate.relative_to(ROOT).as_posix()
    except ValueError:
        return Problem(source, line_number, f"link escapes repository: {target}")

    if relative not in known_paths:
        return Problem(source, line_number, f"missing local target: {target}")
    return None


def check_file(source: Path, known_paths: set[str]) -> tuple[list[Problem], int]:
    problems: list[Problem] = []
    checked_targets = 0
    open_fence: str | None = None

    for line_number, original_line in enumerate(
        source.read_text(encoding="utf-8-sig", errors="replace").splitlines(),
        start=1,
    ):
        fence = FENCE_RE.match(original_line)
        if fence:
            marker = fence.group(1)
            if open_fence is None:
                open_fence = marker[0]
            elif marker[0] == open_fence:
                open_fence = None
            continue
        if open_fence is not None:
            continue

        line = INLINE_CODE_RE.sub("", original_line)
        matches = list(INLINE_LINK_RE.finditer(line))
        matches.extend(HTML_SOURCE_RE.finditer(line))
        reference = REFERENCE_RE.match(line)
        if reference:
            matches.append(reference)

        for match in matches:
            checked_targets += 1
            problem = check_target(
                source,
                line_number,
                match.group("target"),
                known_paths,
            )
            if problem:
                problems.append(problem)

    return problems, checked_targets


def main() -> int:
    files = markdown_files()
    known_paths = repository_paths()
    problems: list[Problem] = []
    checked_targets = 0

    for source in files:
        file_problems, file_target_count = check_file(source, known_paths)
        problems.extend(file_problems)
        checked_targets += file_target_count

    if problems:
        print(f"Found {len(problems)} Markdown link problem(s):", file=sys.stderr)
        for problem in problems:
            print(problem, file=sys.stderr)
        return 1

    print(
        f"OK: checked {checked_targets} links in {len(files)} Markdown files."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
