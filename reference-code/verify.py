#!/usr/bin/env python3
"""Verify vendored upstream Git blobs without contacting the network."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
MANIFEST = json.loads((BASE / "SOURCES.json").read_text(encoding="utf-8"))


def verify(entry):
    path = Path(entry["local_path"] if "local_path" in entry else entry["path"])
    full_path = (BASE.parent / path).resolve()
    if not full_path.is_relative_to(BASE):
        raise ValueError(f"outside reference-code: {path}")
    payload = full_path.read_bytes()
    git_object = b"blob " + str(len(payload)).encode("ascii") + b"\0" + payload
    actual = hashlib.sha1(git_object).hexdigest()
    expected = entry["git_blob_sha1"]
    if actual != expected:
        raise ValueError(f"{path}: wrong Git blob SHA-1: {actual} != {expected}")
    print(f"PASS {path}: {actual}")


def main():
    entries = MANIFEST["vendored"] + MANIFEST["license_files"]
    paths = [entry.get("local_path", entry.get("path")) for entry in entries]
    if len(paths) != len(set(paths)):
        raise ValueError("duplicate paths in SOURCES.json")
    for entry in entries:
        verify(entry)
    print(f"PASS {len(entries)} unchanged upstream blobs")


if __name__ == "__main__":
    main()
