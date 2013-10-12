#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

execute 'start-hadoop-secondarynamenode' do
    command 'echo "starting hadoop-secondarynamenode"'
    notifies :enable, resources(:service => 'hadoop-secondarynamenode')
    notifies :restart, resources(:service => 'hadoop-secondarynamenode')
end

monitrc "hadoop-secondarynamenode" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'hadoop-secondarynamenode',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hadoop-secondarynamenode.pid",
     :monit_service_group => 'hadoop'
  })
end


