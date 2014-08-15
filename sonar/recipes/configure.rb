include_recipe "sonar::service"

template "sonar.properties" do
  path "#{node[:sonar][:dir]}/conf/sonar.properties"
  source "sonar.properties.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :options => node[:sonar][:options]
  )
  notifies :restart, resources(:service => "sonar")
end

template "wrapper.conf" do
  path "#{node[:sonar][:dir]}/conf/wrapper.conf"
  source "wrapper.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "sonar")
end