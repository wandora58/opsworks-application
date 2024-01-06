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

  template "#{current_dir}/db.env" do
    mode 0660
    variables(
      :host =>     (deploy[:database][:host] rescue nil),
      :user =>     (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil)
    )
  end

  execute "run application" do
    command <<-EOH
      nohup python #{current_dir}/main.py &
    EOH
  end

end