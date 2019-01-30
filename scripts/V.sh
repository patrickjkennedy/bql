#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage $1 mutex-name"
    exit 1
else
    rm -rf "$1-lock"
    exit 0
fi