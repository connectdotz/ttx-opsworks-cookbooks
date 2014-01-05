# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# deploy rexster extensions
#
include_recipe 'deploy'
include_recipe 'titan::start-rexster'

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  Chef::Log.debug( "deploying application: #{application}" )

  if (application == node[:titan][:ttx_ext][:app])

    #install ttx-ext 
    Chef::Log.debug( "installing ${application} " )

    #link the app to ttx_ex_home
    link "#{node[:titan][:ttx_ext_home]}" do
      to "#{deploy[:deploy_to]}/current"
      action :create

      #notifies :create, "link[rexster-ttx-ext]", :immediately
    end

    #install rexster-ext-jar
    link "rexster-ttx-ext" do
      target_file "#{node[:titan][:rexster_ext]}/ttx"
      to "#{node[:titan][:ttx_ext_rexster_jar_dir]}"
      action :create
    end

    execute "restart-rexster" do
	  command "echo restart rexster-service for ttx-ext deployment"
	  notifies :run, "execute[start_rexster]", :delayed
    end
  else 
    Chef::Log.debug( "ignoring application: ${application} " )
  end

end

