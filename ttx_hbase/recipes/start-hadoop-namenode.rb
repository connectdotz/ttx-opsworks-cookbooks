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


