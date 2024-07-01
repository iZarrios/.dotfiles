#! /usr/bin/env bash
# set -eux

python_cmd=""

if command -v python3 &> /dev/null; then
  python_cmd="python3"
elif command -v python &> /dev/null; then
  python_cmd="python"
else
  echo "Python is not found"
  exit 1
fi

URL="https://bootstrap.pypa.io/get-pip.py"

curl -L "$URL" | "$python_cmd"
