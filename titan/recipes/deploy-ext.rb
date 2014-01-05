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

  Chef::Log.debug( "deploying application: #{application} to #{deploy[:deploy_to]}" )

  if (application == node[:titan][:ttx_ext_app])

    #install ttx-ext 
    Chef::Log.debug( "install ${application} " )

    #link the app to ttx_ex_home
    link "#{node[:titan][:ttx_ext_home]}/ext/ttx" do
      to "#{deploy[:deploy_to]}/current"
      action :create

      notify :create "link[rexster-ttx-ext]"
    end

    #install rexster-ext-jar
    link "rexster-ttx-ext" do
      target_file "#{node[:titan][:rexster_ext]}/ext/ttx"
      to "#{node[:titan][:ttx_ext_rexster_jar_dir]}"
      action :nothing

	  notifies :run, "execute[start_rexster]", :delayed
    end

  end

end

