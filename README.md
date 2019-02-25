# puppet liagent ( VMware Log Insight Agent )

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with liagent](#setup)
    * [What liagent affects](#what-liagent-affects)
    * [Setup requirements](#setup-requirements)
    * [Yum Repo Creation Optional](#yum-repo-creation-optional)
    * [Beginning with liagent](#beginning-with-liagent)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

> vRealize Log lnsight is a highly scalable log management application with intuitive, actionable dashboards, sophisticated analytics and broad third-party extensibility. It provides deep operational visibility and faster troubleshooting across physical, virtual and cloud environments.

This module then installs and configures the VMware Log Insight Agent from a custom yum repo.

## Setup

This module does not supply the VMware Log Insight Agent installation files. Installation files will need to be aquired from the Deployed VMware Log Insight Server, and the module configured to use it. Users can use yum to install these components if they're self-hosted.

If your deployed VMware Log Insight Agent has the hostname loginsight.localdomain, then your agents can be downloaded from.

https://loginsight.localdomain/admin/agents/

Once you have the agent you can setup an configure a local Yum repo, see [Yum Repo Creation Optional](#yum-repo-creation-optional)

To begin using this module, use the Puppet Module Tool (PMT) from the command line to install this module:
```
# puppet module install liagent
```

This will place the module into your primary module path if you do not utilize the --target-dir directive.

You can also use r10k or code-manager to deploy the module so ensure that you have the correct entry in your Puppetfile.

Once the module is in place, there is just a little setup needed.

This module was designed to work with Hiera in-module Hiera data.

Therefore a node deffinition file should be created.

For example:
```
liagent::srv_hostname: 'loginsight.localdomain'
liagent::service_name: 'liagentd'
liagent::package_manage: true
liagent::package: 'VMware-Log-Insight-Agent'
liagent::version: '4.7.0-9602262'
liagent::loginsight_repo: 'LogInsight_Agent'
```
### What liagent affects 

This Module install the VMware Loginsight Agent Package.

It configures the agent via the config file  /var/lib/loginsight-agent/liagent.ini

It also creates a LogInsight_Agent Yum repo if required.

### Setup Requirements 

In order to Test this module against a working Log Insight Server you can setup a VMware trial for the following products:

+ VMware vSphere Hypervisor 6.7
+ https://my.vmware.com/en/web/vmware/evalcenter?p=free-esxi6
+ VMware vCenter Server Appliance 2018-10-16 | 6.7.0U1 | 3.95 GB | iso
+ https://my.vmware.com/group/vmware/evalcenter?p=vsphere-eval
+ VMware vRealize Log Insight 4.7.0 - Virtual Appliance
+https://my.vmware.com/group/vmware/evalcenter?p=vr-li


Setting this up is out of the scope of this documentation but essentially you need to setup a VMware Lab environemnt.

Install and configure VMware vSphere Hypervisor 6.7

Import and Configure VMware vCenter Server Appliance 6.7.0U1

Import VMware vRealize Log Insight 4.7.0 - Virtual Appliance via vCenter Server

+ Note a reasonable spec lab setup is required, this was tested on a
+ Intel ® NUC6I7KYK Micro Intel® 2600 MHz SOC, IRIS PRO 580. With 32GB Ram
+ Check https://www.vmware.com/resources/compatibility/search.php
+ vCenter Server Appliance - Tiny environment (up to 10 hosts or 100 virtual machines) requires 2 vCPUs & 10 GB Ram
    - The vCenter Server Appliance can be shutdown once the Loginsight appliance is installed if memory is an issue.
+ VMware vRealize Log Insight 4.7.0 - Virtual Appliance requires 4 vCPUs & 8 GB Ram
    - However in this test lab we got away with 2 vCPUs & 4 GB Ram


Further free training can be obtained with a VMware Learning Zone Basic Subscription.

https://mylearn.vmware.com/

The puppet module 'puppetlabs-stdlib'  is also required and testing was done with version '5.1.0'.

## Yum Repo Creation Optional
Due to VMware not offering a public repo for the agent you will need to create a local repo on a simple web server (Apache, Nginx or Lighttpd) that will host the rpm in a yum repo. 

In order to have the commands createrepo and repo-sync available, install the packages createrepo and yum-utils respectively, which are not available in the default RHEL setup:

```
# yum install -y createrepo yum-utils
# mkdir -p /var/www/html/repo
# cp VMware-Log-Insight-Agent-* /var/www/html/repo
# createrepo /var/www/html/repo
```

### Beginning with liagent

Once the VMware vRealize Log Insight agent packages are hosted in the users repository the module is ready to deploy.

## Usage

If a user is installing liagent with packages provided from their local custom repo, this is the most basic way of installing liagent with default settings:

```
include ::liagent
```
This module uses in-module Hiera data. The data directory contains the Hiera files.

```
liagent/data/
├── common.yaml
└── RedHat-family.yaml
```
liagent/data/common.yaml

```
---
liagent::srv_hostname: ~
liagent::proto: 'cfapi'
liagent::port: 9543
liagent::ssl: 'yes'
liagent::ssl_ca_path: ~
liagent::reconnect: ~
liagent::central_config: 'no'
liagent::debug_level: ~
liagent::stats_period: ~
liagent::smart_stats: 'no'
liagent::max_disk_buffer: ~
liagent::logtype: ~
liagent::directory: ~
liagent::include: ~
liagent::package_type: ~
liagent::auto_update: 'no'
liagent::service_manage: true
liagent::service_ensure: true
liagent::service_enable: true
liagent::service_name: liagentd
liagent::service_provider: ~
liagent::package_manage: true
liagent::package: 'VMware-Log-Insight-Agent'
liagent::version: ~
```
liagent/data/RedHat-family.yaml 

```
---
liagent::config_file: '/var/lib/loginsight-agent/liagent.ini'
liagent::logtype: 'syslog'
liagent::directory: '/var/log'
liagent::include: 'include=messages;messages.?;syslog;syslog.?'
liagent::package_type: 'rpm
```

A node deffinition file should be created because some vales are required.
```
liagent::srv_hostname:
```
and 
```
liagent::loginsight_repo: 
```

For example:

/etc/puppetlabs/code/environments/dev/data/nodes/node1.localdomain.yaml

```
liagent::srv_hostname: 'loginsight.localdomain'
liagent::package_manage: true
liagent::package: 'VMware-Log-Insight-Agent'
liagent::version: '4.7.0-9602262'
liagent::loginsight_repo: 'LogInsight_Agent'
```

These can be overidden in the Puppet Console Configuration section or in the three independent layers of configuration.

1. Global
2. Environment
3. Module

Further reading on Hiera 5:

https://puppet.com/docs/puppet/5.0/hiera_migrate_modules.html#module-data-with-yaml-data-files

https://puppet.com/docs/puppet/5.0/hiera_layers.html

## Hiera Data Options

Hostname or IP address of your Log Insight server . String

`liagent::srv_hostname:` 

Manage the Loginsight Service . Boolean True or false

`liagent::service_manage:` true

Ensure the Loginsight Service files have been created. Boolean True or false

`liagent::service_ensure:` true

Ensure the Loginsight Service is enabled. Boolean True or false

`liagent::service_enable:` true

The name of the Loginsight service. String 

`liagent::service_name:` 'liagentd'

Should this module also also managed the package ? Boolean True or false

`liagent::package_manage:` true

The Name of the Loginsight Package . String

`liagent::package:` 'VMware-Log-Insight-Agent'

The Version number of the Loginsight Package . String

`liagent::version:` '4.7.0-9602262'

Name of the Loginsight repo. String

`liagent::loginsight_repo:` 'LogInsight_Agent'

Path to the Loginsight config file . Absolutepath . Default: null

`liagent::config_file::` ~

Protocol can be cfapi (Log Insight REST API), syslog. Default:

`liagent::proto:` 'cfapi'

Log Insight server port to connect to. Default ports for protocols (all TCP):
syslog: 514; syslog with ssl: 6514; cfapi: 9000; cfapi with ssl: 9543. Default:

`liagent::port:` 9543

Is SSL to be used ? String

`liagent::ssl:` 'yes'

Path to the ssl_ca file . Absolutepath . Default: null

`liagent::ssl_ca_path:` ~

Time in minutes to force reconnection to the server.

This option mitigates imbalances caused by long-lived TCP connections. Default: null

`liagent::reconnect:` ~ 

Allow the agent to receive central configuration from the server.
If disabled, only agent-side configuration will be applied. Default: No

`liagent::central_config:` 'no'

Time in minutes to force reconnection to the server.

This option mitigates imbalances caused by long-lived TCP connections. Default: null

`liagent::debug_level:` ~

Frequency to print agent dynamic information in minutes. Default: null

`liagent::stats_period:` ~ 

Allow the agent to automatically decrease dynamic information print period to 1 minute
in case if agent abnormal performance is detected.
If disabled, agent performance won't be monitored at all. StringDefault:  No

`liagent::smart_stats:` 'no'

Max local storage usage limit (data + logs) in MBs. Valid range: 100-2000 MB.

`liagent::max_disk_buffer:` ~

Uncomment the appropriate section to collect system logs
The recommended way is to enable the Linux content pack from LI server. String  Default: syslog

`liagent::logtype:` ~

Path to the log file directory . Absolutepath . Default: /var/log

`liagent::directory:` ~

List of files to be read in the "liagent::directory" . String

`liagent::include:` ~

Type of Package . String . Default : null

`liagent::package_type:` ~

Enable automatic update of the agent. If enabled:
the agent will silently check for updates from the server and
if available will automatically download and apply the update.

`liagent::auto_update:` 'no'

 Default provider Puppet uses to manage services on the system.
 
`liagent::service_provider:` ~


## Reference

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)


## Limitations

This Version is compatible with:

Operating Systems:

RedHat: 6, 7

CentOS: 6, 7

## Development

Currently tested manually on Centos 7, but will eventually add automated testing and are targeting compatibility with other platforms.

Tested with Puppet 6

## VMware Tutorial Videos

Here are some great tutorials from [sysadmintutorials.com](https://www.sysadmintutorials.com) to setup all that you need to get started with setting up a test lab for this module.

[![vSphere 6.7 - How to install and configure VMware ESXi 6.7](http://img.youtube.com/vi/AQLFQW0GvV0/0.jpg)](https://www.youtube.com/watch?v=AQLFQW0GvV0)

[![vSphere 6.7 - How to install and configure VMware vCenter 6.7 Appliance](http://img.youtube.com/vi/U-rilkWMkO4/0.jpg)](http://www.youtube.com/watch?v=U-rilkWMkO4)

[![vSphere 6.5 - How to install and configure VMware vRealize Log Insight 4](http://img.youtube.com/vi/aJeTBO_rWms/0.jpg)](http://www.youtube.com/watch?v=aJeTBO_rWms)

## Contributors

Contributers very, very welcome and I'll buy you a beer if we meet at Puppetconf or meetups.
