include_recipe "java"
include_recipe "opsworks_agent_monit::service"
include_recipe "sonar::packages"

remote_file "#{node[:sonar][:basedir]}/sonarqube-#{node[:sonar][:version]}.zip" do
  source "#{node[:sonar][:mirror]}/sonarqube-#{node[:sonar][:version]}.zip"
  mode "0644"
  checksum "#{node[:sonar][:checksum]}"
  not_if { ::File.exists?("#{node[:sonar][:basedir]}/sonarqube-#{node[:sonar][:version]}.zip") }
end

execute "unzip #{node[:sonar][:basedir]}/sonarqube-#{node[:sonar][:version]}.zip -d #{node[:sonar][:basedir]}" do
  notifies :stop, 'service[sonar]', :immediate
  not_if { ::File.directory?("#{node[:sonar][:basedir]}/sonarqube-#{node[:sonar][:version]}/") }
end

link node[:sonar][:dir] do
  to "#{node[:sonar][:basedir]}/sonarqube-#{node[:sonar][:version]}"
end

link '/etc/init.d/sonar' do
  to "#{node[:sonar][:dir]}/bin/#{node[:sonar][:os_kernel]}/sonar.sh"
end

service 'sonar' do
  supports :status => true, :restart => true, :start => true, :stop => true
  action [:enable, :start]
end

include_recipe "sonar::configure"

# Monitoring by Monit
template "#{node.default[:monit][:conf_dir]}/sonar.monitrc" do
  source "sonar.monitrc.erb"
  cookbook 'sonar'
  owner 'root' and mode 0644
  notifies :reload, "service[monit]", :immediately
end