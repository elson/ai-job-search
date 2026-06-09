#!/usr/bin/env python
"""Compile a Typst cover letter to PDF (and optionally PNG pages).

The PyPI ``typst`` package is a Python binding, not a CLI, so this thin wrapper
is the canonical way to render cover letters in this repo. It points Typst at the
bundled Source Sans 3 fonts (``cover_letters/fonts/``) so output matches the
RenderCV ``classic`` theme without relying on system-installed fonts.

Usage (from the repo root, inside the project venv):

    .venv/bin/python cover_letters/render.py cover_letters/cover_<company>_<role>.typ
    .venv/bin/python cover_letters/render.py cover_letters/cover_<company>_<role>.typ --png

The ``--png`` flag also renders one PNG per page named ``<stem>-{p}.png`` and prints
the page count, which is the quickest way to verify the letter is exactly 1 page.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

import typst

FONT_DIR = Path(__file__).resolve().parent / "fonts"


def main() -> int:
    parser = argparse.ArgumentParser(description="Render a Typst cover letter.")
    parser.add_argument("input", type=Path, help="Path to the .typ cover letter")
    parser.add_argument(
        "--png",
        action="store_true",
        help="Also render one PNG per page and report the page count.",
    )
    args = parser.parse_args()

    src: Path = args.input
    if not src.exists():
        print(f"error: {src} not found", file=sys.stderr)
        return 1

    font_paths = [str(FONT_DIR)]
    # Resolve relative imports (#import "template.typ") against the .typ's folder.
    root = str(src.resolve().parent)

    pdf_out = src.with_suffix(".pdf")
    typst.compile(str(src), output=str(pdf_out), root=root, font_paths=font_paths)
    print(f"wrote {pdf_out}")

    if args.png:
        png_pattern = src.with_name(src.stem + "-{p}.png")
        typst.compile(
            str(src),
            output=str(png_pattern),
            root=root,
            font_paths=font_paths,
            format="png",
            ppi=150,
        )
        pages = sorted(src.parent.glob(src.stem + "-*.png"))
        print(f"rendered {len(pages)} page(s): {[p.name for p in pages]}")
        if len(pages) != 1:
            print("WARNING: cover letter should be exactly 1 page", file=sys.stderr)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
