#!/bin/bash

echo "without cache"
rvm 1.9.3 gemset create rhinestone-benchmark
time rvm 1.9.3@rhinestone-benchmark exec bundle install --gemfile=Gemfile.rgems
rvm --force gemset delete rhinestone-benchmark

echo "with cache"
rvm 1.9.3 gemset create rhinestone-benchmark
time rvm 1.9.3@rhinestone-benchmark exec bundle install
rvm --force gemset delete rhinestone-benchmark

echo "no rubygems"
rvm 1.9.3 gemset create rhinestone-benchmark
time rvm 1.9.3@rhinestone-benchmark exec bundle install --gemfile=Gemfile.proxy
rvm --force gemset delete rhinestone-benchmark
