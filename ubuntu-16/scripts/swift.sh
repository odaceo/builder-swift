#!/bin/bash

# This install script is intended to install Swift.
#
# Environment variables:
# - SWIFT_VERSION: the version to install

# Update your local package index
apt-get update

# Install CLang, LLDB & dependencies
apt-get install -y \
    make \
    libc6-dev \
    clang-3.8 \
    libedit-dev \
    libpython2.7 \
    libicu-dev \
    libssl-dev \
    libxml2 \
    libcurl4-openssl-dev \
    pkg-config \
    lsb-release

# Remove the local package index
rm -rf /var/lib/apt/lists/*

# Create symblic links
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100

# Clone swiftenv
git clone https://github.com/kylef/swiftenv.git ~/.swiftenv

# Installs shims for Swift binaries
swiftenv rehash

# Install Swift
swiftenv install ${SWIFT_VERSION}

# Print installed Swift version
swift --version
