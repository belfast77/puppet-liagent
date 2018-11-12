# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include liagent::install
class liagent::install {

  if $liagent::package_manage == true {

    if $liagent::version == undef {

      package { $liagent::package:
        ensure  => installed,
        require => Yum['$liagent::loginsight_repo'],
      }

    } else {

      package { $liagent::package:
        ensure  => $liagent::version,
        require => Yum['$liagent::loginsight_repo'],
      }
    }
  }
}
