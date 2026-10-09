#!/usr/bin/env python3
"""Explicit opt-in download of pinned, checksummed non-vendored references."""
import argparse
import hashlib
import json
from pathlib import Path
from urllib.request import urlopen

BASE = Path(__file__).resolve().parent
SOURCES = json.loads((BASE / "SOURCES.json").read_text(encoding="utf-8"))
MAX_BYTES = 40 * 1024 * 1024


def check(data, entry):
    if "sha512" in entry:
        actual = hashlib.sha512(data).hexdigest()
        wanted = entry["sha512"]
        method = "SHA-512"
    else:
        actual = hashlib.sha1(
            b"blob " + str(len(data)).encode("ascii") + b"\0" + data
        ).hexdigest()
        wanted = entry["git_blob_sha1"]
        method = "Git blob SHA-1"
    if actual != wanted:
        raise ValueError(f"{entry['key']}: {method} mismatch: {actual} != {wanted}")


def fetch(entry):
    path = (BASE / entry["destination"]).resolve()
    if not path.is_relative_to(BASE / "external"):
        raise ValueError("invalid destination")
    if path.exists():
        check(path.read_bytes(), entry)
        print(f"VERIFIED local {entry['key']} → {path}")
        return
    print(f"FETCH {entry['key']}")
    with urlopen(entry["url"], timeout=45) as remote:
        payload = remote.read(MAX_BYTES + 1)
    if len(payload) > MAX_BYTES:
        raise ValueError(f"{entry['key']}: archive too large")
    check(payload, entry)
    path.parent.mkdir(parents=True, exist_ok=True)
    # No files are written until the checksum verifies.
    path.write_bytes(payload)
    print(f"VERIFIED downloaded {entry['key']} → {path}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("keys", nargs="*", help="source keys; default is all")
    args = parser.parse_args()
    sources = {entry["key"]: entry for entry in SOURCES["optional_sources"]}
    if any(key not in sources for key in args.keys):
        parser.error(f"unknown key; choose from: {', '.join(sorted(sources))}")
    for key in args.keys or sources:
        fetch(sources[key])


if __name__ == "__main__":
    main()
