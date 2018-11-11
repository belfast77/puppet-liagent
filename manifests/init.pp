# liagent
#
# Main class, includes all other classes.
#
# @param srv_hostname
#   Hostname or IP address of your Log Insight server / cluster load balancer. Default:. Default value: loginsight.localdomain 
#
#
class liagent (
  Stdlib::Absolutepath $config_file,
  String $srv_hostname,
  String $proto,
  Optional[Integer[0, 65535]] $port,
#  # Would like to restrict the option here but think it's my lack of
#  # Understanding on how to use bool2str
  String $ssl,
#  Boolean[Stdlib::bool2str[true, 'yes', 'no'] $ssl,
  Optional[Stdlib::Absolutepath] $ssl_ca_path,
  Optional[Integer[15, 60]] $reconnect,
  String $central_config,
#  Boolean[Stdlib::bool2str[true, 'yes', 'no'] $central_config,
  Optional[Integer[0, 2]] $debug_level,
  Optional[Integer[1, 3600]] $stats_period,
  String $smart_stats,
#  Boolean[Stdlib::bool2str[true, 'yes', 'no']] $smart_stats,
  Optional[Integer[100, 2000]] $max_disk_buffer,
  String $filelog,
  String $logtype,
  Stdlib::Absolutepath $directory,
  String $include,
  String $auto_update,
#  Optional[Boolean[Stdlib::bool2str[true, 'yes', 'no']]] $auto_update,
  Boolean $service_manage,
  Boolean $service_ensure,
  Boolean $service_enable,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $package_manage,
  String $package,
  String $version,
  String $loginsight_repo,
)

  {

  contain liagent::install
  contain liagent::config
  contain liagent::service
  contain liagent::yum

  Class['::liagent::install']
  -> Class['::liagent::config']
  ~> Class['::liagent::service']
}
