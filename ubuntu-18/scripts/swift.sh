#!/bin/bash

# This install script is intended to install Swift.
#
# Environment variables:
# - SWIFT_VERSION: the version to install

# Update your local package index
apt-get update

# Install dependencies
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
apt-get install -y \
    libatomic1 \
    libbsd0 \
    libcurl4 \
    libxml2 \
    libedit2 \
    libsqlite3-0 \
    libc6-dev \
    binutils \
    libgcc-5-dev \
    libstdc++-5-dev \
    libpython2.7 \
    pkg-config \
    tzdata

# Remove the local package index
rm -rf /var/lib/apt/lists/*

# Everything up to here should cache nicely between Swift versions, assuming dev dependencies change little
SWIFT_PLATFORM="ubuntu18.04"
SWIFT_BRANCH="swift-${SWIFT_VERSION}-release"
SWIFT_VERSION="swift-${SWIFT_VERSION}-RELEASE"

# Download GPG keys, signature and Swift package, then unpack, cleanup and execute permissions for foundation libs
SWIFT_URL=https://swift.org/builds/${SWIFT_BRANCH}/$(echo "${SWIFT_PLATFORM}" | tr -d .)/${SWIFT_VERSION}/${SWIFT_VERSION}-${SWIFT_PLATFORM}.tar.gz

# Download Swift package
curl -fSsL ${SWIFT_URL} -o swift.tar.gz

# Download GPG keys and signature
curl -fSsL ${SWIFT_URL}.sig -o swift.tar.gz.sig
export GNUPGHOME="$(mktemp -d)"
gpg --quiet --keyserver ha.pool.sks-keyservers.net --recv-keys A62AE125BBBFBB96A6E042EC925CC1CCED3D1561
gpg --batch --verify --quiet swift.tar.gz.sig swift.tar.gz

# Unpack and execute permissions for foundation libs
tar -xzf swift.tar.gz --directory / --strip-components=1
chmod -R o+r /usr/lib/swift

# Cleanup 
rm -r "${GNUPGHOME}"
rm -r swift.tar.gz.sig swift.tar.gz

# Print Installed Swift Version
swift --version
