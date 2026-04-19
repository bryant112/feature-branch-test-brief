#!/usr/bin/env bash
set -euo pipefail

html_path=""
pdf_path=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --html-path|-HtmlPath)
            html_path="${2:-}"
            shift 2
            ;;
        --pdf-path|-PdfPath)
            pdf_path="${2:-}"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

if [[ -z "$html_path" || -z "$pdf_path" ]]; then
    echo "Usage: render-html-to-pdf.sh --html-path <html-file> --pdf-path <pdf-file>" >&2
    exit 1
fi

browser=""
for candidate in \
    google-chrome \
    google-chrome-stable \
    chromium \
    chromium-browser \
    microsoft-edge \
    microsoft-edge-stable \
    "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
    "/mnt/c/Program Files/Microsoft/Edge/Application/msedge.exe" \
    "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" \
    "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"
do
    if command -v "$candidate" >/dev/null 2>&1; then
        browser="$(command -v "$candidate")"
        break
    fi
    if [[ -x "$candidate" ]]; then
        browser="$candidate"
        break
    fi
done

if [[ -z "$browser" ]]; then
    echo "No supported browser found. Install Chrome, Chromium, or Edge." >&2
    exit 1
fi

html_full_path="$(realpath "$html_path")"
pdf_full_path="$(realpath -m "$pdf_path")"
mkdir -p "$(dirname "$pdf_full_path")"
rm -f "$pdf_full_path"

html_uri="$(python3 - "$html_full_path" <<'PY'
from pathlib import Path
import sys

print(Path(sys.argv[1]).resolve().as_uri())
PY
)"

"$browser" --headless --disable-gpu --no-pdf-header-footer "--print-to-pdf=$pdf_full_path" "$html_uri" >/dev/null 2>&1

if [[ ! -f "$pdf_full_path" ]]; then
    echo "Browser PDF render did not produce an output file." >&2
    exit 1
fi

if [[ ! -s "$pdf_full_path" ]]; then
    echo "Browser PDF render produced an empty PDF file." >&2
    exit 1
fi
