#!/usr/bin/env bash

function handle_error {
    echo "Failed" >&2
    exit 1
}

trap handle_error ERR

for file in tests/configs/*; do
  echo "Testing $(basename "${file}")"
  test=$(helm template chart --values "${file}" | sed '/^#/d')
  expected=$(sed '/^#/d' "tests/results/$(basename "${file}")" )
  helm lint --quiet --strict chart --values "${file}"
  diff  <(echo "${test}" ) <(echo "${expected}")
done

echo Passed
