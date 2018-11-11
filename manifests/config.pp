# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# /var/lib/loginsight-agent/liagent.ini
# 
# Symbolic Link
# /etc/liagent.ini
#
# @example
#   include liagent::config
class liagent::config {

  file { $liagent::config_file:
    ensure  => file,
    owner   => root,
    group   => root,
    content => epp('liagent/liagent.ini.epp'),
    mode    => '0644',
    notify  => Class['liagent::service'],
  }

}
