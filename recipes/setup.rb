Chef::Log.info("********** Setup! **********")

describe pip('Flask') do
  it { should be_installed }
end