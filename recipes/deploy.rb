Chef::Log.info("********** Deploy! **********")

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
      python main.py
    EOH
  end