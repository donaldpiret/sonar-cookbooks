include_recipe "java"
include_recipe "opsworks_agent_monit::service"
include_recipe "sonar::packages"

remote_file "#{node['sonar']['basedir']}/sonar-#{node['sonar']['version']}.zip" do
  source "#{node['sonar']['mirror']}/sonar-#{node['sonar']['version']}.zip"
  mode "0644"
  checksum "#{node['sonar']['checksum']}"
  not_if { ::File.exists?("#{node['sonar']['basedir']}/sonar-#{node['sonar']['version']}.zip") }
end

execute "unzip #{node['sonar']['basedir']}/sonar-#{node['sonar']['version']}.zip -d #{node['sonar']['basedir']}" do
  not_if { ::File.directory?("#{node['sonar']['basedir']}/sonar-#{node['sonar']['version']}/") }
end

link node['sonar']['dir'] do
  to "#{node['sonar']['basedir']}/sonar-#{node['sonar']['version']}"
end

include_recipe "sonar::configure"

# Monitoring by Monit
template "#{node.default[:monit][:conf_dir]}/sonar.monitrc" do
  source "sonar.monitrc.erb"
  cookbook 'sonar'
  owner 'root' and mode 0644
  notifies :restart, "service[sonar]", :immediately
end