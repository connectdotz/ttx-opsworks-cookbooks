#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-master" do
	command "echo starting hbase master..."
	notifies :enable, "service[hbase-master]"
	notifies :restart, "service[hbase-master]"
end

monitrc "hbase-master" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'hbase-master',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hbase-master.pid",
     :monit_service_group => 'hbase'
  })
end


