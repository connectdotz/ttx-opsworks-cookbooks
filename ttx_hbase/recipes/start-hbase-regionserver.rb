#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-regionserver" do
	command "echo starting hbase regionserver..."
	notifies :enable, "service[hbase-regionserver]"
	notifies :restart, "service[hbase-regionserver]"
end

monitrc "hbase-regionserver" do
    template_cookbook "ttx_common"
    template_source "basic-monitrc.conf.erb"
    variables({
     :monit_service => 'hbase-regionserver',
     :monit_check_type => 'pidfile',
     :monit_service_check_target  => "#{node[:ttx_hbase][:hadoop][:pid_dir]}/hbase-regionserver.pid",
     :monit_service_group => 'hbase'
  })
end


