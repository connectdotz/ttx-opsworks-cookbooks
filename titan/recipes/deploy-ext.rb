# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# deploy rexster extensions
#
include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path node[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  #install gremlin-scripts
  ttx_ext_script_dest = "#{node[:tita][:ttx_ext_script_dir]}"
  ttx_ext_script_jar = "#{node[:deploy_to]}/#{node[:titan][:ttx_ext_script_jar]}"
  bash "unpack gremlin-scripts" do
    user deploy[:user]
    group deploy[:group]
    code <<-EOH
        mkdir -p #{ttx_ext_script_dest} 
        unzip -o #{ttx_ext_script_jar} -d #{ttx_ext_script_dest} 
    EOH
    only_if { application == node[:titan][:ttx_ext_script_app] }

	notifies :restart, "service[rexster]", :delayed
  end

  #install rexster-ext-jar
  link "#{node[:tita][:ttx_ext_jar_dir]}" do
    to node[:deploy_to]
    action :create
    only_if { application == node[:titan][:ttx_ext_jar_app] }    

	notifies :restart, "service[rexster]", :delayed
    
  end

end

