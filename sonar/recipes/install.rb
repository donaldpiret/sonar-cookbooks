include_recipe "java"
include_recipe "opsworks_agent_monit::service"
include_recipe "sonar::packages"

remote_file "/opt/sonar-#{node['sonar']['version']}.zip" do
  source "#{node['sonar']['mirror']}/sonar-#{node['sonar']['version']}.zip"
  mode "0644"
  checksum "#{node['sonar']['checksum']}"
  not_if { ::File.exists?("/opt/sonar-#{node['sonar']['version']}.zip") }
end

execute "unzip /opt/sonar-#{node['sonar']['version']}.zip -d /opt/" do
  not_if { ::File.directory?("/opt/sonar-#{node['sonar']['version']}/") }
end

link "/opt/sonar" do
  to "/opt/sonar-#{node['sonar']['version']}"
end

# Auto start
service "sonar" do
  supports :status => true, :restart => true
  stop_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh stop"
  start_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh start"
  status_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh status"
  restart_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh restart"
  action [ :enable ]
end

include_recipe "sonar::configure"

# Monitoring by Monit
template "#{node.default[:monit][:conf_dir]}/sonar.monitrc" do
  source "sonar.monitrc.erb"
  cookbook 'sonar'
  owner 'root' and mode 0644
  notifies :restart, "service[sonar]", :immediately
end