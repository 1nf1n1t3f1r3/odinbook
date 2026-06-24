#!/usr/bin/env bash

set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean

#  Add this when there's no DB or a fresh DB
# bin/rails db:migrate