# == Class: kvm-host
#
# Full description of class kvm-host here.
# See also http://www.server-world.info/en/note?os=Fedora_20&p=kvm
#   https://cloudstack.apache.org/docs/en-US/Apache_CloudStack/4.0.2/html/Installation_Guide/hypervisor-kvm-install-flow.html
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { kvm-host:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class kvm-host {



package { 'qemu-kvm': ensure => present }
package { 'libvirt': ensure => present }
# TODO make this dependent on OS, fedora=yes/centos-6=no
package { 'virt-install': ensure => present }
package { 'bridge-utils': ensure => present }

package { 'virt-top': ensure => present }

# tools for manipulating the content of a machines storage.
package { 'libguestfs-tools': ensure => present }

# Agent for reporting virtual guest IDs to subscription-manager
# TODO make this dependent on OS, fedora=yes/centos-6=no
#package { 'virt-who': ensure => present }

# Print kernel messages from a Linux virtual machine.
# TODO make this dependent on OS, fedora=yes/centos-6=no
#package { 'virt-dmesg': ensure => present }

# Graphical Virtual Machine Manager
package { 'virt-manager': ensure => present }

# Graphical read-only Virtual Machine Viewer
package { 'virt-viewer': ensure => present }

# Performance monitoring for the Linux kernel
package { 'perf': ensure => present }


# This package contains some diagnostics and debugging tools for KVM
package { 'qemu-kvm-tools': ensure => present }


# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Virtualization_for_Servers/2.2/html/Administration_Guide/virt-v2v-scripts.html
#  virt-v2v

service { 'libvirtd':
  ensure => running,
  enable => true,
  require => Package [ 'libvirt' ],
}

}
