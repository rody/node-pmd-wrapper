#!/bin/sh

set -e

PMD_VERSION=6.18.0
DOWNLOAD_URL="https://github.com/pmd/pmd/releases/download/pmd_releases%2F${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip"

printf "Downloading PMD version %s from %s ..." "$PMD_VERSION" "$DOWNLOAD_URL"

rm -rf ./vendor
mkdir ./vendor

cd vendor/ || exit 1
curl -sL "DOWNLOAD_URL" -o "pmd-bin-${PMD_VERSION}.zip"

unzip "pmd-bin-${PMD_VERSION}.zip"
rm -f "pmd-bin-${PMD_VERSION}.zip"

mv "pmd-bin-${PMD_VERSION}" pmd
