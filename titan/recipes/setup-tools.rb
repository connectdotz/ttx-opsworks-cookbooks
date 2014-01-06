#
# setup the tools used by titan graphs
#

directory node[:titan][:tools_home] do
  action :create
end

remote_directory "#{node[:titan][:tools_home]}/bin" do
  source "ttx-tool-bin"
  files_backup 0
  files_mode 00755 
  mode 00755

  action: create
end



