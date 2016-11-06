#!/bin/sh
neutron net-create tenant-network
neutron subnet-create --name tenant-subnet tenant-network 172.18.20.0/24
