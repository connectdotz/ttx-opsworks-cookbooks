#
# setup the login account include shell and some commonly used tools
#

directory "/root/.aws" do
  recursive true
  action :create
end

template "/root/.aws/config" do
  source "aws_config.erb"
  owner 'root' and mode 0600
end


