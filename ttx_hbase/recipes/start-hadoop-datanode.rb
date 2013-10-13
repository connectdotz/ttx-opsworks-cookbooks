# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start datanode
#

include_recipe "ttx_common::monit-service"
include_recipe "ttx_hbase::hadoop-services"

SERVICE='hadoop-datanode'

template "monit-#{SERVICE}" do
    path "#{node[:ttx][:monit][:conf_dir]}/#{SERVICE}.monitrc"
    cookbook "ttx_common"
    source "basic-monitrc.conf.erb"
    mode 0644
    variables({
        :monit_service => "#{SERVICE}",
        :monit_check_type => 'pidfile',
        :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hadoop-#{node[:ttx_hbase][:hadoop][:user]}-datanode.pid",
        :monit_service_group => 'hadoop'
    })
    notifies :restart, "service[monit]"

    action :nothing
end

execute 'start-hadoop-datanode' do
    command 'echo "starting hadoop-datanode"'
    notifies :enable, resources(:service => "#{SERVICE}")
    notifies :restart, resources(:service => "#{SERVICE}")

    notifies :create, resources(:template => "monit-#{SERVICE}")
end


