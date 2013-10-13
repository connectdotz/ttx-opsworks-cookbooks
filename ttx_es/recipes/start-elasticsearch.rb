# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "ttx_common::monit-service"

SERVICE='elasticsearch'

template "monit-#{SERVICE}" do
    path "#{node[:ttx][:monit][:conf_dir]}/#{SERVICE}.monitrc"
    cookbook "ttx_common"
    source "basic-monitrc.conf.erb"
    mode 0644
    variables({
        :monit_service => "#{SERVICE}",
        :monit_check_type => 'pidfile',
        :monit_service_check_target  => "#{node[:elasticsearch][:pid_file]}",
        :monit_service_group => 'titan'
    })
    notifies :restart, "service[monit]"

    action :nothing
end

service "#{SERVICE}" do
    supports :status => true, :restart => true
    action [ :enable, :restart ]

    notifies :create, resources(:template => "monit-#{SERVICE}")
end



