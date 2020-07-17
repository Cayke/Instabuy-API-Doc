#!/bin/bash

# must exec npm install -g s3-deploy before
bundle exec middleman build --clean
s3-deploy './build/index.html' --cwd './build/' --bucket websites.instabuy.com.br/docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/linear.html' --cwd './build/' --bucket websites.instabuy.com.br/docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/dmcard.html' --cwd './build/' --bucket websites.instabuy.com.br/docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/admin.html' --cwd './build/' --bucket websites.instabuy.com.br/docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/tetra.html' --cwd './build/' --bucket websites.instabuy.com.br/docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/**' --cwd './build/' --bucket websites.instabuy.com.br/docs.instabuy.com.br --gzip html,js,css --cache 31536000 --deleteRemoved