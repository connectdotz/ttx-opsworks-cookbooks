#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_common::monit-service"
include_recipe "ttx_hbase::hadoop-services"

SERVICE='hadoop-namenode'

template "monit-#{SERVICE}" do
    path "#{node[:ttx][:monit][:conf_dir]}/#{SERVICE}.monitrc"
    cookbook "ttx_common"
    source "basic-monitrc.conf.erb"
    mode 0644
    variables({
        :monit_service => "#{SERVICE}",
        :monit_check_type => 'pidfile',
        :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hadoop-#{node[:ttx_hbase][:hadoop][:user]}-namenode.pid",
        :monit_service_group => 'hadoop'
    })
    notifies :restart, "service[monit]"

    action :nothing
end

ruby_block "format-and-start-namenode" do
	block do
		node[:ttx_hbase][:hadoop][:name_dir].each do |dir|
			if (!File.exists?("#{dir}/current/VERSION"))
				cmd = "echo 'Y' | #{node[:ttx_hbase][:hadoop][:home]}/bin/hadoop namenode -format"
				%x( #{cmd} )
				Chef::Log.info( "namenode is formatted: #{cmd}" )
			end
			break
		end
	end
    notifies :enable, resources(:service => "#{SERVICE}")
    notifies :restart, resources(:service => "#{SERVICE}")

    notifies :create, resources(:template => "monit-#{SERVICE}")
    
end


