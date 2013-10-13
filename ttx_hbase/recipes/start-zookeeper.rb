#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_common::monit-service"
include_recipe "ttx_hbase::hbase-services"

SERVICE='zookeeper'

template "monit-#{SERVICE}" do
    path "#{node[:ttx][:monit][:conf_dir]}/#{SERVICE}.monitrc"
    cookbook "ttx_common"
    source "basic-monitrc.conf.erb"
    mode 0644
    variables({
        :monit_service => "#{SERVICE}",
        :monit_check_type => 'pidfile',
        :monit_service_check_target  => "#{node[:ttx_hbase][:hbase][:pid_dir]}/hbase-#{node[:ttx_hbase][:hbase][:user]}-zookeeper.pid",
        :monit_service_group => 'hbase'
    })
    notifies :restart, "service[monit]"

    action :nothing
end

execute "start-zookeeper" do
	command "echo starting zookeeper..."
    notifies :enable, resources(:service => "#{SERVICE}")
    notifies :restart, resources(:service => "#{SERVICE}")

    notifies :create, resources(:template => "monit-#{SERVICE}")
end

