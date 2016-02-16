#
# Cookbook Name:: new_relic
# Recipe:: default
#
# Copyright (c) 2016 Noda Shinpei, All Rights Reserved.

remote_file "#{Chef::Config[:file_cache_path]}/newrelic-repo.rpm" do
  source node['new_relic']['rpm_repo']
  action :create
end

execute "Upgrade rpm repo" do
  command "rpm -Uvh #{Chef::Config[:file_cache_path]}/newrelic-repo.rpm"
end

package "newrelic-sysmond" do
  action :install
end

execute "configure new relic" do
  command "nrsysmond-config --set license_key=node['new_relic']['license_key']"
end

service "newrelic-sysmond" do
  action [ :start, :enable ]
end
