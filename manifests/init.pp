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

# The 'acpi=ht' has to be set in the /boot/grub/grub.cfg

package { 'qemu-kvm': ensure => present }
package { 'libvirt': ensure => present }
package { 'virt-install': ensure => present }
package { 'bridge-utils': ensure => present }

service { 'libvirtd':
  ensure => running,
  enable => true,
  require => Package [ 'libvirt' ],
}
}
