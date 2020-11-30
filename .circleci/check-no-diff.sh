#!/usr/bin/env bash

set -eu

APP_ROOT=$(cd $(dirname $0)/..; pwd)
TARGET_PATH="$1"
if [ -z "$TARGET_PATH" ]; then
    echo "Require target path as the first argument."
    exit 1
fi

(
  cd $APP_ROOT

  last_merge_commit="$(git log --merges --first-parent --pretty=format:"%h" -n1)"
  head_commit="$(git log --pretty=format:"%h" -n1)"
  compare_hashes="${last_merge_commit}..${head_commit}"
  diff_files="$(git diff --name-only ${compare_hashes})"
  if [ "${last_merge_commit}" == "${head_commit}" ]; then
      diff_files="$(git log -m -1 --name-only --pretty="format:" ${last_merge_commit})"
  fi

  echo "compare url         : ${CIRCLE_COMPARE_URL}"
  echo "compare commit hashs: ${compare_hashes}"
  echo "target path         : ${TARGET_PATH}"
  echo "diff files          :"
  echo -e "${diff_files}\n"

  if [[ "${diff_files}" =~ "$TARGET_PATH" ]]; then
      echo -e "Diff files are included in ${TARGET_PATH}.\n"
      exit 1
  else
      echo -e "Diff files are not included in ${TARGET_PATH}.\n"
      exit 0
  fi
)
