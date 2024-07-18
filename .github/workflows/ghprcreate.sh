#!/bin/bash
gh pr create \
  --title "[bot] Bump stolostron/prometheus to v2.53.1" \
  --body "## Description
  This is an automated version bump from CI.
  The logs for this run can be found [in the syncbot repo actions](https://github.com/rhobs/syncbot/actions/runs/9987259484).
  If you wish to perform this manually, execute the following commands from stolostron/prometheus repo:
  ```
  git fetch https://github.com/prometheus/prometheus --tags
  if ! git merge refs/tags/v2.53.1 --no-edit; then
    git checkout --theirs CHANGELOG.md VERSION go.mod go.sum .golangci.yml
    git checkout --ours
    git add CHANGELOG.md VERSION go.mod go.sum .golangci.yml
    git merge --continue
  fi
  go mod tidy
  go mod vendor
if ! git diff --exit-code origin/main web/ui; then
  make assets-compress
  find web/ui/static -type f -name '*.gz' -exec git add -f {} \;
  git add -f web/ui/embed.go
  git diff --cached --exit-code || git commit -s -m "[bot] assets: generate"
fi

  if [ -f scripts/rh-manifest.sh ]; then
    bash scripts/rh-manifest.sh
    git add rh-manifest.txt
    git diff --cached --exit-code || git commit -s -m "[bot] update rh-manifest.txt"
  fi
  ```" \
  --author "github-actions[bot]<github-actions[bot]@users.noreply.github.com>" \
  --base release-2.12 \
  --head automated-updates-acm-release-2.12 \
  --repo rhobs/acm-prometheus