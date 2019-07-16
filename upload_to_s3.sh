#!/bin/bash

# must exec npm install -g s3-deploy before

s3-deploy './build/index.html' --cwd './build/' --region sa-east-1 --bucket docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/linear.html' --cwd './build/' --region sa-east-1 --bucket docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/dmcard.html' --cwd './build/' --region sa-east-1 --bucket docs.instabuy.com.br --gzip --cache 120 --deleteRemoved
s3-deploy './build/**' --cwd './build/' --region sa-east-1 --bucket docs.instabuy.com.br --gzip html,js,css --cache 31536000 --deleteRemoved