#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

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
    notifies :enable, resources(:service => 'hadoop-namenode')
    notifies :restart, resources(:service => 'hadoop-namenode')
end

monitrc "hadoop-namenode" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'hadoop-namenode',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hadoop-namenode.pid",
     :monit_service_group => 'hadoop'
  })
end

