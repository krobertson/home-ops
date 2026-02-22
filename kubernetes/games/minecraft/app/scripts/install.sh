#!/bin/bash

set -e

echo "-----------------------------------------"
echo "Installation starting"
echo "-----------------------------------------"
echo ""

RELEASE_MANIFEST=/tmp/release_manifest.json
curl -sSL -o ${RELEASE_MANIFEST} https://launchermeta.mojang.com/mc/game/version_manifest.json

LATEST_VERSION=$(jq -r '.latest.release' ${RELEASE_MANIFEST})
LATEST_SNAPSHOT_VERSION=$(jq -r '.latest.snapshot' ${RELEASE_MANIFEST})

echo -e "Latest version is ${LATEST_VERSION}"
echo -e "Latest snapshot is ${LATEST_SNAPSHOT_VERSION}"

# Check if already installed
INSTALLED_VERSION=""
if [ -e /game/server.version ]; then
  INSTALLED_VERSION="$(cat /game/server.version)"
  echo "Installed version is ${INSTALLED_VERSION}"
fi

if [ "${LATEST_VERSION}" != "${INSTALLED_VERSION}" ]; then
  # Get the manifest for the latest version
  VERSION_MANIFEST_URL=$(jq --arg VERSION ${LATEST_VERSION} -r '.versions | .[] | select(.id== $VERSION )|.url' ${RELEASE_MANIFEST})
  VERSION_MANIFEST=/tmp/version_manifest.json
  curl -sSL -o ${VERSION_MANIFEST} ${VERSION_MANIFEST_URL}

  # Download the server.jar
  serverurl=$(jq -r '.downloads.server.url' ${VERSION_MANIFEST})
  serversha=$(jq -r '.downloads.server.sha1' ${VERSION_MANIFEST})
  echo ""
  echo "Downloading /game/server.jar..."
  echo "$serverurl"
  curl -sSL -o /tmp/server.jar ${serverurl}

  (
    cd /tmp
    echo ""
    echo "Validating download with SHA1 (${serversha})"
    echo "${serversha}  server.jar" > server.sha1
    sha1sum -c server.sha1
  )

  mv /tmp/server.jar /tmp/server.sha1 /game/
  echo "${LATEST_VERSION}" > /game/server.version
  rm -f ${RELEASE_MANIFEST} ${VERSION_MANIFEST}
else
  echo ""
  echo "No need to install/upgrade"
fi

echo ""
echo "-----------------------------------------"
echo "Installation completed"
echo "-----------------------------------------"
