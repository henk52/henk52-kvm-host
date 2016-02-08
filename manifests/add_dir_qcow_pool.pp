file { '/virt_images':
  ensure => directory,
}

service {'libvirtd':
  ensure => running,
}


libvirt_pool { 'qcows':
  ensure     => present,
  type       => 'dir',
  autostart  => true,
  target     => '/virt_images',
  require    => Service[ 'libvirtd' ],
}

