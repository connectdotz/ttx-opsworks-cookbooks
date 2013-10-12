#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hbase-services"

execute "start-zookeeper" do
	command "echo starting zookeeper..."
	notifies :enable, "service[zookeeper]"
	notifies :restart, "service[zookeeper]"
end

monitrc "zookeeper" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'zookeeper',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/zookeeper.pid",
     :monit_service_group => 'hbase'
  })
end

