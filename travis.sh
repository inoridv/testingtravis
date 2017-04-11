#!/bin/bash
set -e

PATHS="
*.php
"

CHANGED_FILES="$(git diff --name-only --diff-filter=d origin/master -- $PATHS)"

echo $CHANGED_FILES

if [[ -n "${CHANGED_FILES// }" ]]; then
  echo "$CHANGED_FILES" | xargs phpcs -v --standard=Drupal,DrupalPractice

  for FILE in $CHANGED_FILES; do
    php -l $FILE
  done
fi