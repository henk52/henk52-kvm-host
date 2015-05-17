# TODO make the name configurable.
libvirt_pool { 'vg_images' :
  ensure     => present,
  type       => 'logical',
  autostart  => true,
  target     => '/dev/vg_images',
  require    => Service [ 'libvirtd' ],
}
#  sourcedev  => [ '/dev/sdb1', '/dev/sdc1' ],
#  sourcename => 'vg',

