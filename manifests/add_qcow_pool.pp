# see also: https://forge.puppetlabs.com/puppetlabs/lvm
logical_volume { 'virt_images':
  ensure       => present,
  volume_group => 'vg_images',
  size         => '110G',
}

filesystem { '/dev/vg_images/virt_images':
  ensure  => present,
  fs_type => 'ext4',
  require => Logical_volume['virt_images'],
}

file { '/virt_images':
  ensure => directory,
}

# TODO C Find out how to get '1 2' written to /etc/fstab instead of '0 0'
mount { '/virt_images':
        device  => '/dev/vg_images/virt_images',
        fstype  => 'ext4',
        ensure  => mounted,
        options => 'defaults',
        atboot  => true,
        require => [
               File ['/virt_images' ],
               Filesystem['/dev/vg_images/virt_images'],
             ],

}

service {'libvirtd':
  ensure => running,
}


libvirt_pool { 'qcows':
  ensure     => present,
  type       => 'dir',
  autostart  => true,
  target     => '/virt_images',
  require    => [ 
                  Service [ 'libvirtd' ],
                  Mount['/virt_images'],
                ]
}

