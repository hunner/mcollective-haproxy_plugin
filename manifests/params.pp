class haproxy_plugin::params {
  if $::puppetversion =~ /Puppet Enterprise/ {
    $plugins_dir = '/opt/puppet/libexec/mcollective/mcollective'
  } else {
    $plugins_dir = '/usr/libexec/mcollective/mcollective'
  }
}
