# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include liagent::yum
class liagent::yum {

  $repo_baseurl = 'http://node1/repo/'

  yumrepo { 'LogInsight_Agent':
    baseurl  => $repo_baseurl,
    descr    => 'LogInsight_Agent',
    enabled  => 1,
    gpgcheck => 0,
  }
}
