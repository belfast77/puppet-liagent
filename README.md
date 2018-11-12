
# WORK IN PROGRESS DO NOT USE
# liagent ( VMware Log Insight Agent )

Welcome to your new module. A short overview of the generated parts can be found in the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with liagent](#setup)
    * [What liagent affects](#what-liagent-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with liagent](#beginning-with-liagent)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Briefly tell users why they might want to use your module. Explain what your module does and what kind of problems users can solve with it.

This should be a fairly short description helps the user decide if your module is what they want.

## Setup

### What liagent affects 

This Module install the VMware Loginsight Agent.

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

+ Note a resaonable spec lab setup is required, this was tested on a
+ Intel ® NUC6I7KYK Micro Intel® 2600 MHz SOC, IRIS PRO 580. With 32GB Ram
+ Check https://www.vmware.com/resources/compatibility/search.php
+ vCenter Server Appliance - Tiny environment (up to 10 hosts or 100 virtual machines) requires 2 vCPUs & 10 GB Ram
    - The vCenter Server Appliance can be shutdown once the Loginsight appliance is installed if memory is an issue.
+ VMware vRealize Log Insight 4.7.0 - Virtual Appliance requires 4 vCPUs & 8 GB Ram


Further free training can be obtained with a VMware Learning Zone Basic Subscription.

https://mylearn.vmware.com/

The puppet module 'puppetlabs-stdlib'  is also required and testing was done with version '5.1.0'.


### Beginning with liagent

The very basic steps needed for a user to get the module up and running. This can include setup steps, if necessary, or it can be an example of the most basic use of the module.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
