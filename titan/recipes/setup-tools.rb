#
# setup the tools used by titan graphs
#

include_recipe 'ttx_common::setup-aws-cmd'

directory node[:titan][:tools_home] do
  recursive true
  action :create
end

remote_directory "#{node[:titan][:tools_home]}/bin" do
  source "ttx-tools-bin"
  files_backup 0
  files_mode 00755 
  mode 00755

  action :create
end

template "graph.sh" do
  path "#{node[:titan][:tools_home]}/bin/graph.sh"
  source "graph_sh.erb"
  owner 'root' and mode 0655
  action :create
end




