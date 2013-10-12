# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "ttx_hbase::hadoop-services"

execute 'start-hadoop-datanode' do
    command 'echo "starting hadoop-datanode"'
    notifies :enable, resources(:service => 'hadoop-datanode')
    notifies :restart, resources(:service => 'hadoop-datanode')
end

monitrc "hadoop-datanode" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'hadoop-datanode',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hadoop-datanode.pid",
     :monit_service_group => 'hadoop'
  })
end

