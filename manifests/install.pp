# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include liagent::install
class liagent::install {

#  include liagent::yum

  if $liagent::package_manage == true {

    if $liagent::version == undef {

      package { $liagent::package:
        ensure  => installed,
#        require => Yumrepo['$liagent::loginsight_repo'],
      }

    } else {

      package { $liagent::package:
        ensure  => $liagent::version,
#        require => Yumrepo['$liagent::loginsight_repo'],
      }
    }
  }
}
