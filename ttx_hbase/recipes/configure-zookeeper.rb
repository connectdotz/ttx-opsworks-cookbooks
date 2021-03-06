#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# triggered by the OpsWork configuration lifecycle event when any instance came online in the stack
#

include_recipe 'ttx_hbase::opsworks-context'
include_recipe 'ttx_hbase::setup-hbase-conf'
include_recipe 'ttx_hbase::hbase-services'

execute "restart-zookeeper" do
	command "echo perform configure operation"
	only_if { node[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] || 
		node[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] ||
		node[:ttx_hbase][:opsworks][:hbase_rootdir_changed]}
	notifies :run, "bash[setup-hbase-conf]", :immediately
	notifies :restart, "service[zookeeper]", :delayed
end


