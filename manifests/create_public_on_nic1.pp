# 'interfaces' is a 'facter' entry, that can be accessed via the '$'
$arInterfaceList = split($interfaces, ',')
$szSecondInterface = $arInterfaceList[1]
#notify{ "Second NIC: $szSecondInterface": }

$szPublicBridgeName = 'publicbr0'

network::bridge { "$szPublicBridgeName":
  ensure        => 'up',
  stp           => true,
  delay         => '0',
}
#  bridging_opts => 'priority=65535',


network::if::bridge { "$szSecondInterface":
  ensure => 'up',
  bridge => "$szPublicBridgeName",
  require => Network::Bridge[ "$szPublicBridgeName" ],
}

