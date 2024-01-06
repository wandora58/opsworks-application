Chef::Log.info("********** Setup! **********")

execute "install packages" do
  command <<-EOH
    pip install Flask
  EOH
end