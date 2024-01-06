Chef::Log.info("********** Deploy! **********")

execute "run application" do
  command <<-EOH
    pwd
    ls
  EOH
end