# Copyright 2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not
# use this file except in compliance with the License. A copy of the License is
# located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions
# and limitations under the License.

# opsworks
default[:titan][:opsworks][:es_layer] = 'es'
default[:titan][:opsworks][:es_hostname_changed] = false
default[:titan][:opsworks][:hbase_master_layer] = 'hbase-master'
default[:titan][:opsworks][:hbase_master_changed] = false

# runtime env
default['titan']['titan_version'] = '0.4.1'
default['titan']['rexster_version'] = '2.4.0'
default['titan']['runtime_env'] = 'beta'
default['titan']['base_dir'] = '/opt/thingtrix/titan'
default['titan']['rexster_path'] = 'rexster-server'
default['titan']['titan_path'] = 'titan'

## ttx extensions
default['titan']['ttx_ext_path'] = 'ttx-ext'
default['titan']['ttx_ext_script_jar'] = 'ThingTrixGremlineScripts-0.0.1-SNAPSHOT.jar'
default['titan']['ttx_ext_script_app'] = 'rexster-ext-gremlin-scripts"
default['titan']['ttx_ext_jar_app'] = 'rexster-ext-jar"

# execution tuning
default['titan']['rexster_java_options'] = '-Xms64m -Xmx512m'
default['titan']['rexster_start_delay'] = 0

# titan logging and debugging
default['titan']['log_dir'] = '/var/log/titan'
default['titan']['pid_dir'] = '/var/titan/pid'
default['titan']['log_level'] = 'INFO'
default['titan']['debug'] = false 

# composite attributes
node.normal['titan']['rexster_home'] = "#{node['titan']['base_dir']}/#{node['titan']['rexster_path']}"
node.normal['titan']['titan_home'] = "#{node['titan']['base_dir']}/#{node['titan']['titan_path']}"

node.normal['titan']['ttx_ext'] = "#{node['titan']['base_dir']}/#{node['titan']['ttx_ext_path']}"
node.normal['titan']['ttx_ext_script_dir'] = "#{node['titan']['ttx_ext']}/gremlin-scripts"
node.normal['titan']['ttx_ext_jar_dir'] = "#{node['titan']['rexster_home']}/ext/ttx"

# es
default['titan']['es']['host_name'] = '127.0.0.1'

#hbase
default['titan']['hbase']['host_name'] = '127.0.0.1'
