# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "ttx_common::monit-service"
include_recipe "titan::rexster-service"

debug_flag = ( node['titan']['debug'] == true ? "-d" : "" )

SERVICE='rexster'

template "monit-#{SERVICE}" do
    path "#{node[:ttx][:monit][:conf_dir]}/#{SERVICE}.monitrc"
    cookbook "ttx_common"
    source "basic-monitrc.conf.erb"
    mode 0644
    variables({
        :monit_service => "#{SERVICE}",
        :monit_check_type => 'pidfile',
        :monit_service_check_target  => "#{node[:titan][:pid_dir]}/#{SERVICE}.pid",
        :monit_service_group => 'titan'
    })
    notifies :restart, "service[monit]"

    action :nothing
end

# execute delay
execute 'start_rexster' do
    command "sleep #{node['titan']['rexster_start_delay']}"
    environment ({ "$REXTER_SERVICE_DEBUG" => "#{debug_flag}"} )

    notifies :enable, resources(:service => "#{SERVICE}")
    notifies :restart, resources(:service => "#{SERVICE}")

    notifies :create, resources(:template => "monit-#{SERVICE}")

    action :nothing
end



