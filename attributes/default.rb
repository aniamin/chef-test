default['myapp']['user'] = 'myapp'
default['myapp']['group'] = 'myapp'
default['myapp']['name'] = 'myapp'
default['myapp']['config'] = 'myapp.conf'
default['myapp']['document_root'] = '/srv/apache/myapp'

default['myapp']['database']['host'] = 'localhost'
default['myapp']['database']['username'] = 'root'
default['myapp']['database']['password'] = node['mysql']['server_root_password']
default['myapp']['database']['dbname'] = 'myapp'

default['myapp']['database']['app']['username'] = 'myapp_app'
default['myapp']['database']['app']['password'] = 'supersecret'

default['myapp']['database']['seed_file'] = '/tmp/myapp-create.sql'
