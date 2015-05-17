# The 'acpi=ht' has to be set in the /boot/grub/grub.cfg
#class { '::hyperctl': state => 'enable' }

# TODO - Fix this - This is a hack, SELinux is now forcefully disabled.
augeas { 'hyperthread_enable':
  context => '/files/etc/default/grub',
  changes => [
    'set GRUB_CMDLINE_LINUX \'"\"noapic vconsole.font=latarcyrheb-sun16 selinux=0 $([ -x /usr/sbin/rhcrashkernel-param ] && /usr/sbin/rhcrashkernel-param || :) acpi=ht rhgb quiet\""\'',
  ],
  notify => Exec['grub-update'],
}
#    'set GRUB_CMDLINE_LINUX "\"noapic vconsole.font=latarcyrheb-sun16 selinux=0 \$([ -x /usr/sbin/rhcrashkernel-param ] && /usr/sbin/rhcrashkernel-param || :) acpi=ht rhgb quiet\""',

exec { 'grub-update':
  refreshonly => true,
  command => '/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg',
}

