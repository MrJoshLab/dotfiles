#!/usr/bin/env bash
boundary \
  targets \
  list \
  -recursive \
  -format=json | jq -r '.items[] | "\(.id)\t\(.attributes.default_client_port)\t\(.name)"'
