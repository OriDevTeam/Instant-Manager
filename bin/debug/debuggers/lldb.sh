#!/bin/bash
binary=$1
core=$2

cd ../../../configurations

lldb $binary -c $core bt all