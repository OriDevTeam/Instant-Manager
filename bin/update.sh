#!/bin/bash
pushd ".." > /dev/null

git clone https://github.com/OriDevTeam/Instant-Manager
rsync -ur Instant-Manager/* .
rm -rf Instant-Manager/

popd > /dev/null