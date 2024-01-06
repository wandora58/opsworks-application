Chef::Log.info("********** Deploy Start! **********")

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  execute "set database env" do
    environment(
      "DB_HOST" => deploy[:database][:host]
    )
  end

  current_dir = ::File.join(deploy[:deploy_to], 'current')

  execute "run application" do
    command <<-EOH
      nohup 2>&1 python #{current_dir}/main.py &
    EOH
  end

end