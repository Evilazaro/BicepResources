#!/bin/bash

# Delete all local tags
git tag -l | xargs -n 1 git tag -d

# Delete all remote tags
git tag -l | xargs -n 1 -I {} git push origin :refs/tags/{}