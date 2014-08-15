service 'monit' do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end

service "sonar" do
  supports :status => true, :restart => true, :reload => false
  action [ :nothing ]
end