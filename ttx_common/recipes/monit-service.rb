#
# monit service 
#

#include_recipe "opsworks_agent_monit::service"

service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end


