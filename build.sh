#!/usr/bin/env -S bash -eEu -o pipefail

if [ $# != 0 ] || [ "${1:-}" == "-h" ]; then
    panic-in "$0" 'invokes ptoroc for codegen and does some bookkeeping; expects no arguments'
fi

PYTHON_BASE=./target/python
PYTHON_SRC="$PYTHON_BASE"
JAVA_BASE=./target/java
JAVA_SRC="$JAVA_BASE/src/main/java/telir"
RUST_BASE=./target/rust
RUST_SRC="$RUST_BASE/src"

mkdir -p "$PYTHON_SRC/telir" "$JAVA_SRC" "$RUST_SRC"

docker run --rm -v"$(pwd)":/code -w /code rvolosatovs/protoc -I=. \
    --python_out="$PYTHON_SRC" \
    --java_out="$JAVA_SRC" \
    --rust_out=experimental-codegen=enabled,kernel=cpp:"$RUST_SRC" \
    telir/*.proto

cp LICENSE.txt "$PYTHON_BASE/"
cp LICENSE.txt "$JAVA_BASE/"
cp LICENSE.txt "$RUST_BASE/"

cp -r static/* target

zip -rq target/telir-python.zip "$PYTHON_BASE"
zip -rq target/telir-java.zip "$JAVA_BASE"
zip -rq target/telir-rust.zip "$RUST_BASE"
