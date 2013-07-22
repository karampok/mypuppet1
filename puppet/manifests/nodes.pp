# /etc/puppet/manifests/nodes.pp
import "myclass"
node 'monserver.cway.com' {
  include monserver
  #include "client_*.pp"
  check_mk::addclientmk { 'client0':  cname => 'client0', ip=> '192.168.60.100', site=>'monitor', }
  check_mk::addclientmk { 'client1':  cname => 'client1', ip=> '192.168.60.100', site=>'monitor', }
  check_mk::addclientmk { 'client2':  cname => 'client2', ip=> '192.168.60.100', site=>'monitor', }
  check_mk::addclientmk { 'client3':  cname => 'client3', ip=> '192.168.60.100', site=>'monitor', }
}

node "client0.cway.com" {
  include common
  include monclient
}

node "puppet" {
  include common
  include puppetmaster
}

node "gitlab.cway.com" {
  include common
  include deploygitlab
}
