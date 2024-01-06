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

  file '#{current_dir}/database.env' do
    content 'DB_HOST: #{deploy[:database][:host]}'
    mode '0600'
  end

  execute "run application" do
    command <<-EOH
      python #{current_dir}/main.py
    EOH
  end

end