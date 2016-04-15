#!/usr/bin/env bats

@test "raid10 module is loaded" {
  lsmod | grep -q raid10
  [ $? -eq 0 ]
}

@test "ntfs module is blacklisted" {
  grep -q blacklist /etc/modprobe.d/ntfs.conf
  [ $? -eq 0 ]
}

@test "foo module has no config" {
  test -f /etc/modprobe.d/foo.conf || true
}

@test "raid456 module is loaded" {
  lsmod | grep -q raid456
  [ $? -eq 0 ]
}
