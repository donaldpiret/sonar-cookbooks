service 'monit' do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end

service "sonar" do
  supports :status => true, :restart => true, :reload => false
  stop_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh stop"
  start_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh start"
  status_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh status"
  restart_command "sh /opt/sonar/bin/#{node['sonar']['os_kernel']}/sonar.sh restart"
  action [ :nothing ]
end