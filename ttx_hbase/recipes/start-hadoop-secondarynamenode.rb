#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_common::monit-service"
include_recipe "ttx_hbase::hadoop-services"

SERVICE='hadoop-secondarynamenode'

template "monit-#{SERVICE}" do
    path "#{node[:ttx][:monit][:conf_dir]}/#{SERVICE}.monitrc"
    cookbook "ttx_common"
    source "basic-monitrc.conf.erb"
    mode 0644
    variables({
        :monit_service => "#{SERVICE}",
        :monit_check_type => 'pidfile',
        :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hadoop-#{node[:ttx_hbase][:hadoop][:user]}-secondarynamenode.pid",
        :monit_service_group => 'hadoop'
    })
    notifies :restart, "service[monit]"

    action :nothing
end

execute 'start-hadoop-secondarynamenode' do
    command 'echo "starting hadoop-secondarynamenode"'
    notifies :enable, resources(:service => "#{SERVICE}")
    notifies :restart, resources(:service => "#{SERVICE}")

    notifies :create, resources(:template => "monit-#{SERVICE}")
end

