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
    clang \
    libicu-dev \
    libcurl4 \
    lsb-release

# Remove the local package index
rm -rf /var/lib/apt/lists/*

# Create symblic links
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6-0 100

# Clone swiftenv
git clone https://github.com/kylef/swiftenv.git ~/.swiftenv

# Installs shims for Swift binaries
swiftenv rehash

# Install Swift
swiftenv install ${SWIFT_VERSION}

# Print installed Swift version
swift --version
