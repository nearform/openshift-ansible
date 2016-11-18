#!/bin/sh
OCP_VERSION=${OCP_VERSION:-3.2}
sudo subscription-manager repos --enable="rhel-7-server-ose-${OCP_VERSION}-rpms"

