# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include liagent::service
class liagent::service {
  if $liagent::service_manage == true {
    service { 'liagentd':
      ensure     => $liagent::service_ensure,
      enable     => $liagent::service_enable,
      name       => $liagent::service_name,
      provider   => $liagent::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
