# liagent
#
# Main class, includes all other classes.
#
# @param srv_hostname
#   Hostname or IP address of your Log Insight server / cluster load balancer. Default:. Default value: loginsight.localdomain 
#
#
class liagent (
  String $srv_hostname,
  String $proto,
  Optional[Integer[0, 65535]] $port,
  Boolean[Stdlib::bool2str[true, 'yes', 'no'] $ssl
  Optional[Stdlib::Absolutepath] $ssl_ca_path
  Optional[Integer[15, 60]] $reconnect
  Boolean[Stdlib::bool2str[true, 'yes', 'no'] $central_config
  Optional[Integer[0, 2]] $debug_level
  Optional[Integer[1, 3600]] $stats_period
  Boolean[Stdlib::bool2str[true, 'yes', 'no'] $smart_stats
  Optional[Integer[100, 2000]] $max_disk_buffer
  String $filelog
  String $syslog
  Stdlib::Absolutepath $directory
  String $include
  Optional[Boolean[Stdlib::bool2str[true, 'yes', 'no']] $auto_update
  Boolean $service_manage,
  Boolean $service_ensure,
  Boolean $service_enable,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $package_manage,
  Array[String] $package,
  String $version,
  string $loginsight_repo,
) {

  contain liagent::install
  contain liagent::config
  contain liagent::service

  Class['::liagent::install']
  -> Class['::liagent::config']
  ~> Class['::liagent::service']
}
