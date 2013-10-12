#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#
#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-master-backup" do
	command "echo starting hbase master-backup..."
	notifies :enable, "service[hbase-master-backup]"
	notifies :restart, "service[hbase-master-backup]"
end

monitrc "hbase-master-backup" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'hbase-master-backup',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hbase-master-backup.pid",
     :monit_service_group => 'hbase'
  })
end


