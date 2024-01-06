Chef::Log.info("********** Deploy Start! **********")

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  current_dir = ::File.join(deploy[:deploy_to], 'current')

  execute "run application" do
    command <<-EOH
      python #{current_dir}/main.py #{deploy[:database][:host]}
    EOH
  end

end