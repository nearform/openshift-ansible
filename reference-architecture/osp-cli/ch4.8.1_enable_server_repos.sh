#!/bin/bash
sudo subscription-manager repos --disable="*"
sudo subscription-manager repos \
  --enable="rhel-7-server-rpms" \
  --enable=rhel-7-server-extras-rpms \
  --enable=rhel-7-server-optional-rpms
