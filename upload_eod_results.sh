#!/usr/bin/env bash
#
# Sync evaluation outputs into GitHub repo *and* keep directory layout tidy.
# -------------------------------------------------------------------------

set -euo pipefail

# ---------- EDIT THESE PATHS AS NEEDED -----------------------------------
SRC_PARENT="/Users/skim/Desktop/EODSystem/results"     # source root
DST_PARENT="/Users/skim/Desktop/quant-strat-live-performance/metrics"
REPO_DIR="/Users/skim/Desktop/quant-strat-live-performance"
# -------------------------------------------------------------------------

cd "$REPO_DIR"

############################################################################
# ONE-TIME MIGRATION SECTION (idempotent – safe to run every day)
############################################################################

# 1) Rename 'all' → 'legacy_all' (only if not already renamed)
if [ -d "${DST_PARENT}/all" ] && [ ! -d "${DST_PARENT}/legacy_all" ]; then
  echo "Renaming metrics/all → metrics/legacy_all ..."
  git mv "${DST_PARENT}/all" "${DST_PARENT}/legacy_all"
fi

# 2) Remove 'v4' directory from repo (if it still exists)
if [ -d "${DST_PARENT}/v4" ]; then
  echo "Removing obsolete metrics/v4 ..."
  git rm -r "${DST_PARENT}/v4"
fi

############################################################################
# DAILY SYNC SECTION
############################################################################

# Ensure destination sub-dirs exist
mkdir -p "${DST_PARENT}/backtest" "${DST_PARENT}/live"

# Sync only selected trees
for SUB in backtest live; do
  rsync -av --delete "${SRC_PARENT}/${SUB}/" "${DST_PARENT}/${SUB}/"
done

if [ -f "${SRC_PARENT}/README.md" ]; then
  rsync -av "${SRC_PARENT}/README.md" "${DST_PARENT}/"   # puts it at metrics/README.md
fi

############################################################################
# GIT COMMIT & PUSH (only if something changed)
############################################################################

git pull --quiet origin main                   # fast-forward to avoid conflicts
git add metrics/backtest metrics/live          # stage updated dirs

# also stage anything that was moved/removed in migration section
git add -A metrics       # or: git add --all metrics

# add other single files that may change
git add README.md dashboard.py 2>/dev/null || true

if git diff --cached --quiet; then
  echo "No private-repo changes; skipping commit."
else
  git commit -m "Daily metrics sync $(date +'%Y-%m-%d')" || true
  git push origin main
fi


############################################################################
# PUBLISH FULL WORKING TREE (single-commit snapshot) TO PUBLIC REPO
############################################################################
PUBLIC_URL="https://${GH_PAT}@github.com/sehunkeem/quant-strat-performance-public.git"


# 1) Build a temp tree that has *everything* except the .git folder
PUB_DIR=$(mktemp -d)
rsync -a --delete --exclude='.git' ./ "$PUB_DIR/"

# 2) One-commit repo
(
  cd "$PUB_DIR"
  git init -q
  git config user.name  "Metrics Bot"
  git config user.email "metrics-bot@noreply.github.com"

  git add -A
  git commit -q -m "Snapshot $(date +'%Y-%m-%d')"
  git branch -M main          # make sure branch is 'main'

  # overwrite yesterday’s snapshot
  git push -q -f "$PUBLIC_URL" main
)

rm -rf "$PUB_DIR"


##!/usr/bin/env bash
##
## Sync evaluation outputs (all/  and  v4/) into GitHub repo
## --------------------------------------------------------------------
#
## ----- EDIT THESE TWO PATHS ------------------------------------------------
#SRC_PARENT="/Users/skim/Desktop/EODSystem/results"                 # source root with all/  v4/
#DST_PARENT="/Users/skim/Desktop/quant-strat-live-performance/metrics"  # target in repo
## --------------------------------------------------------------------------
#REPO_DIR="/Users/skim/Desktop/quant-strat-live-performance"
#
#set -e   # exit on error
#
## Ensure destination sub-dirs exist
#mkdir -p "${DST_PARENT}/all" "${DST_PARENT}/v4"
#
## ----------------------------------------------------------------------------
## 1) Sync *only* the two evaluation sub-trees
## ----------------------------------------------------------------------------
#for SUB in all v4; do
#  rsync -av --delete "${SRC_PARENT}/${SUB}/" "${DST_PARENT}/${SUB}/"
#done
#
## ----------------------------------------------------------------------------
## 2) Git commit & push (only if something changed)
## ----------------------------------------------------------------------------
#cd "$REPO_DIR"
#
#git pull --quiet origin main            # fast-forward to avoid conflicts
#git add metrics/all metrics/v4          # stage only these dirs
## (add other files you track, e.g. README or dashboards)
#git add README.md dashboard.py 2>/dev/null || true
#
#if git diff --cached --quiet; then
#  echo "No changes to commit."
#  exit 0
#fi
#
#git commit -m "Daily metrics upload $(date +'%Y-%m-%d')"
#git push origin main
