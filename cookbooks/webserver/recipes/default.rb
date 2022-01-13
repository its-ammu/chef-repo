#
# Cookbook:: webserver
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

mysql_service 'default' do
  port '3306'
  version '8.0'
  initial_root_password 'password'
  action [:create, :start]
end

mysql_database 'todo' do
  user 'root'
  action :create
end

mysql_user 'admin' do
  password 'password'
  action :create
end

mysql_user 'admin' do
  password 'password'
  database_name 'todo'
  host '%'
  privileges [:select,:update,:insert]
  action :grant
end

package 'httpd'
service 'httpd' do
action [:enable, :start]
end

template '/var/www/html/index.html' do
source 'index.html.erb'
end

