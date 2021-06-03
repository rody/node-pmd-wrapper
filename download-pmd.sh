#!/bin/sh

set -e

PMD_VERSION=6.35.0
DOWNLOAD_URL="https://github.com/pmd/pmd/releases/download/pmd_releases%2F${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip"

[ -d "./.cache" ] || mkdir ./.cache

if [ -f "./.cache/pmd-bin-${PMD_VERSION}.zip" ]; then
  printf "Using cached version of PMD at ./.cache/pmd-bin-%s.zip\n" "${PMD_VERSION}"
else
  printf "Downloading PMD version %s from %s ...\n" "$PMD_VERSION" "$DOWNLOAD_URL"
  curl -sL "$DOWNLOAD_URL" -o "./.cache/pmd-bin-${PMD_VERSION}.zip"
fi

rm -rf ./vendor
mkdir ./vendor

unzip "./.cache/pmd-bin-${PMD_VERSION}.zip" -d ./vendor
mv "./vendor/pmd-bin-${PMD_VERSION}" "./vendor/pmd"

exit 0
