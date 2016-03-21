#
# Cookbook Name:: myapp
# Recipe:: webserver
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

group node['myapp']['group']

user node['myapp']['user'] do
  group node['myapp']['group']
  system true
  shell '/bin/bash'
end

include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

include_recipe 'php::module_mysql'

# disable default site
apache_site '000-default' do
  enable false
end

# create apache config
template "#{node['apache']['dir']}/sites-available/#{node['myapp']['config']}" do
  source 'apache2.conf.erb'
  notifies :restart, 'service[apache2]'
end

# create document root
directory "#{node['myapp']['document_root']}" do
  action :create
  mode '0755'
  recursive true
end

# write site
template "#{node['myapp']['document_root']}/index.php" do
  source 'index.php.erb'
  mode '0644'
end

# enable myapp
apache_site "#{node['myapp']['config']}" do
  enable true
end
