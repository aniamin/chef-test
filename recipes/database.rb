#
# Cookbook Name:: myapp
# Recipe:: database
#
# Copyright (C) 2012 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_database node['myapp']['database']['dbname'] do
  connection(
    :host => node['myapp']['database']['host'],
    :username => node['myapp']['database']['username'],
    :password => node['myapp']['database']['password']
  )
  action :create
end

mysql_database_user node['myapp']['database']['app']['username'] do
  connection(
    :host => node['myapp']['database']['host'],
    :username => node['myapp']['database']['username'],
    :password => node['myapp']['database']['password']
  )
  password node['myapp']['database']['app']['password']
  database_name node['myapp']['database']['dbname']
  host node['myapp']['database']['host']
  action [:create, :grant]
end

# Write schema seed file to filesystem
cookbook_file node['myapp']['database']['seed_file'] do
  source 'myapp-create.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

# Seed database with test data
execute 'initialize myapp database' do
  command "mysql -h #{node['myapp']['database']['host']} -u #{node['myapp']['database']['app']['username']} -p#{node['myapp']['database']['app']['password']} -D #{node['myapp']['database']['dbname']} < #{node['myapp']['database']['seed_file']}"
  not_if  "mysql -h #{node['myapp']['database']['host']} -u #{node['myapp']['database']['app']['username']} -p#{node['myapp']['database']['app']['password']} -D #{node['myapp']['database']['dbname']} -e 'describe users;'"
end
