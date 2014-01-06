#
# setup the login account include shell and some commonly used tools
#

cookbook_file "/tmp/bashrc" do
	source "bashrc.part"
	backup false
end

remote_directory "~/bin" do
  source "login-bin"
  files_backup 10
  files_owner node[:ttx][:login][:user]
  files_group node[:ttx][:login][:group]
  files_mode 00755 
  owner node[:ttx][:login][:user]
  group node[:ttx][:login][:group]
  mode 00755

  action: create
end

template "/etc/init.d/hadoop-namenode" do
  source "hadoop-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'namenode',
  })
end


